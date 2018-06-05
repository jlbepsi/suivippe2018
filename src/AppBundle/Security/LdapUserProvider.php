<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 05/06/18
 * Time: 16:50
 */

namespace AppBundle\Security;

use Symfony\Component\Ldap\Entry;
use Symfony\Component\Security\Core\User\LdapUserProvider as SymfonyLdapUserProvider;
use Symfony\Component\Security\Core\User\User;

class LdapUserProvider extends SymfonyLdapUserProvider
{
    protected function loadUser($username, Entry $entry)
    {
        $roles = ['ROLE_USER']; // Actually we should be using $this->defaultRoles, but it's private. Has to be redesigned.

        // Obtention du dn
        $distinguishedName = strtolower($entry->getAttribute('distinguishedName')[0]);

        // Les profs sont dans l'OU prof
        if (strpos($distinguishedName, 'ou=prof') > 1) {
            $roles = ['ROLE_PROF'];
        }

        return new User($username, null, $roles); // Create and return the user object
    }
}