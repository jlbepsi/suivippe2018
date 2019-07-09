<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 05/06/18
 * Time: 16:50
 */

namespace AppBundle\Security;

use Exception;
use Symfony\Component\Ldap\Entry;
use Symfony\Component\Ldap\Exception\ConnectionException;
use Symfony\Component\Ldap\LdapInterface;
use Symfony\Component\Security\Core\Exception\InvalidArgumentException;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;
use Symfony\Component\Security\Core\Exception\UsernameNotFoundException;
use Symfony\Component\Security\Core\User\User;

use AppBundle\Entity\UserLdap;
use AppBundle\Manager\UserLdapManager;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Security\Core\User\UserProviderInterface;

class LdapUserProvider implements UserProviderInterface
{
    //private $userLdap;
    private $ldap;
    private $baseDn;
    private $searchDn;
    private $searchPassword;
    private $defaultRoles;
    private $uidKey;
    private $defaultSearch;
    private $passwordAttribute;

    /**
     * @param LdapInterface $ldap
     * @param string        $baseDn
     * @param string        $searchDn
     * @param string        $searchPassword
     * @param array         $defaultRoles
     * @param string        $uidKey
     * @param string        $filter
     * @param string        $passwordAttribute
     */
    public function __construct(LdapInterface $ldap, $baseDn, $searchDn = null, $searchPassword = null, array $defaultRoles = array(), $uidKey = 'sAMAccountName', $filter = '({uid_key}={username})', $passwordAttribute = null)
    {
        if (null === $uidKey) {
            $uidKey = 'sAMAccountName';
        }

        $this->ldap = $ldap;
        $this->baseDn = $baseDn;
        $this->searchDn = $searchDn;
        $this->searchPassword = $searchPassword;
        $this->defaultRoles = $defaultRoles;
        $this->uidKey = $uidKey;
        $this->defaultSearch = str_replace('{uid_key}', $uidKey, $filter);
        $this->passwordAttribute = $passwordAttribute;
    }

    /**
     * @param string $username
     * @return User|UserInterface
     */
    public function loadUserByUsername($username)
    {
        return $this->loadUserAsUserLdap($username, false);
    }

    /**
     * @param $login
     * @return UserLdap
     */
    public function loadUserLdapByLogin($login)
    {
        return $this->loadUserAsUserLdap($login, true);
    }


    public function loadUsersByClasse($classe)
    {
        $users = array();

        try {
            $this->ldap->bind($this->searchDn, $this->searchPassword);
            // subquery = utilisateur actif / options BTS
            $subquery = "(roomNumber=1)(businessCategory=bts)";
            $query = ($classe == null ?
                "(&(objectClass=inetOrgPerson)" . $subquery . ")":
                "(&(objectClass=inetOrgPerson)" . $subquery . "(l=" . $classe . "))");
            $search = $this->ldap->query($this->baseDn, $query);
        } catch (ConnectionException $e) {
            throw new UsernameNotFoundException(sprintf('Classe "%s" not found.', $classe), 0, $e);
        }

        $entries = $search->execute();

        foreach ($entries as $entry) {

            $username = "";
            try {
                if (null !== $this->uidKey) {
                    $username = $this->getAttributeValue($entry, $this->uidKey);
                }
            } catch (InvalidArgumentException $e) {
            }

            $users[] = $this->loadInternalUserLdap($username, $entry);
        }

        return $users;
    }

    /**
     * {@inheritdoc}
     */
    public function refreshUser(UserInterface $user)
    {
        if (!$user instanceof User) {
            throw new UnsupportedUserException(sprintf('Instances of "%s" are not supported.', \get_class($user)));
        }

        return new User($user->getUsername(), null, $user->getRoles());
    }

    /**
     * {@inheritdoc}
     */
    public function supportsClass($class)
    {
        return 'Symfony\Component\Security\Core\User\User' === $class;
    }



    /**
     * @param $login
     * @param $returnUserLdap
     * @return UserLdap|User
     */
    private function loadUserAsUserLdap($login, $returnUserLdap)
    {
        try {
            $this->ldap->bind($this->searchDn, $this->searchPassword);
            $login = $this->ldap->escape($login, '', LdapInterface::ESCAPE_FILTER);
            $query = str_replace('{username}', $login, $this->defaultSearch);
            $search = $this->ldap->query($this->baseDn, $query);
        } catch (ConnectionException $e) {
            throw new UsernameNotFoundException(sprintf('User "%s" not found.', $login), 0, $e);
        }

        $entries = $search->execute();
        $count = \count($entries);

        if (!$count) {
            throw new UsernameNotFoundException(sprintf('User "%s" not found.', $login));
        }

        if ($count > 1) {
            throw new UsernameNotFoundException('More than one user found');
        }

        $entry = $entries[0];

        try {
            if (null !== $this->uidKey) {
                $login = $this->getAttributeValue($entry, $this->uidKey);
            }
        } catch (InvalidArgumentException $e) {
        }

        $userLdap = $this->loadInternalUserLdap($login, $entry);
        if ($userLdap == null)
            return null;

        return ($returnUserLdap ?
            $userLdap :
            new User($login, null, $userLdap->getRoles())
        );
    }

    /**
     * Loads a user from an LDAP entry.
     *
     * @param string $username
     * @param Entry  $entry
     *
     * @return UserLdap
     */
    private function loadInternalUserLdap($username, Entry $entry)
    {
        $canConnect = false;
        $userLdap = null;

        try
        {
            // Obtention de l'utilisateur
            $userLdap = UserLdapManager::getUserFromEntry($username, $entry);

            // L'utilisateur doit être actif
            if ($userLdap->isActif())
            {
                // Les profs ou l'administratif ont le role PROF
                if ($userLdap->isInRole('ROLE_PROF') || $userLdap->isInRole('ROLE_SUIVIPPE_ADMIN') || $userLdap->isInRole('ROLE_SUPER_ADMIN'))
                {
                    $canConnect = true;
                }
                else
                {
                    // C'est un étudiant, il doit être inscrit à l'option BTS

                    // Obtention de l'option BTS
                    if ($userLdap->isBts())
                        $canConnect = true;
                }

                if ($canConnect) {
                    return $userLdap; // Create and return the user object
                }
            }
        }
        catch (Exception $exception)
        {
            //
        }

        return null;
    }


    /**
     * Fetches a required unique attribute value from an LDAP entry.
     *
     * @param Entry|null $entry
     * @param string $attribute
     * @return string
     */
    private function getAttributeValue(Entry $entry, $attribute)
    {
        if (!$entry->hasAttribute($attribute)) {
            throw new InvalidArgumentException(sprintf('Missing attribute "%s" for user "%s".', $attribute, $entry->getDn()));
        }

        $values = $entry->getAttribute($attribute);

        if (1 !== \count($values)) {
            throw new InvalidArgumentException(sprintf('Attribute "%s" has multiple values.', $attribute));
        }

        return $values[0];
    }

    /**
     * @return UserLdap
     */
    public function getUserLdap()
    {
        return $this->userLdap;
    }


}