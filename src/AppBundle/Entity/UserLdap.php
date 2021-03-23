<?php

namespace AppBundle\Entity;

use Symfony\Component\Ldap\Entry;

/**
 * UserLdap
 *
 */
class UserLdap
{

    /**
     * @var string
     *
     */
    private $login;

    /**
     * @var string
     *
     */
    private $classe;

    /**
     * @var string
     *
     */
    private $nom;

    /**
     * @var string
     *
     */
    private $prenom;

    /**
     * @var string
     *
     */
    private $mail;

    /**
     * @var string[]
     *
     */
    private $roles;

    /**
     * @var boolean
     *
     */
    private $bts;

    /**
     * @var string
     *
     */
    private $parcours;


    /**
     * @var string
     *
     */
    private $numexamen;

    /**
     * @var int
     *
     */
    private $actif;

    /**
     * @var int
     *
     */
    private $sexe;


    /**
     * UserLdap constructor.
     * @param $username
     * @param Entry|null $entry
     */
    public function __construct($username, Entry $entry = null)
    {
        if ('' === $username || null === $username) {
            throw new \InvalidArgumentException('The username cannot be empty.');
        }
        $this->login = $username;

        if ($entry != null) {
            $this->setClasse(strtoupper($entry->getAttribute('l')[0]));
            // Les profs ou l'administratif ont la classe INT_*
            /*if (substr($this->classe, 0, 4) == "INT_") {
                $this->bts = false;
            } else {
                $this->bts = ($entry->getAttribute('businessCategory')[0] == 'BTS');
            }*/
            if ($this->classe == "B1" || $this->classe == "B2") {
                $this->bts = ($entry->getAttribute('businessCategory')[0] == 'BTS');
                $this->parcours = strtoupper($entry->getAttribute('description')[0]);
                $this->setNumexamen($entry->getAttribute('carLicense')[0]);
            } else {
                $this->bts = false;
            }
            $roles = $entry->getAttribute('employeeType')[0];
            $this->roles = array_map('trim', explode(',', $roles));

            $this->setActif(intval($entry->getAttribute('roomNumber')[0]));
            $this->setMail($entry->getAttribute('mail')[0]);
            $this->setNom($entry->getAttribute('sn')[0]);
            $this->setPrenom($entry->getAttribute('givenName')[0]);
            try {
                $this->setSexe($entry->getAttribute('title')[0]);
            } catch (\Exception $exception ) {
                $this->setSexe(0);
            }
        }
    }


    /**
     * Get login
     *
     * @return string 
     */
    public function getLogin()
    {
        return $this->login;
    }

    /**
     * Set classe
     *
     * @param string $classe
     * @return UserLdap
     */
    public function setClasse($classe)
    {
        $this->classe = $classe;

        return $this;
    }

    /**
     * Get classe
     *
     * @return string 
     */
    public function getClasse()
    {
        return $this->classe;
    }

    /**
     * Set nom
     *
     * @param string $nom
     * @return UserLdap
     */
    public function setNom($nom)
    {
        $this->nom = $nom;

        return $this;
    }

    /**
     * Get nom
     *
     * @return string 
     */
    public function getNom()
    {
        return $this->nom;
    }

    /**
     * Set prenom
     *
     * @param string $prenom
     * @return UserLdap
     */
    public function setPrenom($prenom)
    {
        $this->prenom = $prenom;

        return $this;
    }

    /**
     * Get prenom
     *
     * @return string 
     */
    public function getPrenom()
    {
        return $this->prenom;
    }

    /**
     * Get Nom + prenom
     *
     * @return string
     */
    public function getNomlong()
    {
        return ucwords($this->nom) . " " . ucfirst($this->prenom);
    }

    /**
     * Set mail
     *
     * @param string $mail
     * @return UserLdap
     */
    public function setMail($mail)
    {
        $this->mail = $mail;

        return $this;
    }

    /**
     * Get mail
     *
     * @return string 
     */
    public function getMail()
    {
        return $this->mail;
    }

    /**
     * Set roles
     *
     * @param string[] $roles
     * @return UserLdap
     */
    public function setRoles($roles)
    {
        $this->roles = $roles;

        return $this;
    }


    /**
     * Return true if role is present
     *
     * @param string $role
     * @return boolean
     */
    public function isInRole($role)
    {
        return in_array($role, $this->roles);
    }
    /**
     * Get roles
     *
     * @return []
     */
    public function getRoles()
    {
        return $this->roles;
    }

    /**
     * Set parcours
     *
     * @param string $parcours
     * @return UserLdap
     */
    public function setParcours($parcours)
    {
        $this->parcours = $parcours;

        return $this;
    }

    /**
     * Get parcours
     *
     * @return string
     */
    public function getParcours()
    {
        return $this->parcours;
    }

    /**
     * Get parcours
     *
     * @return string
     */
    public function getParcoursLibelle()
    {
        $libelle = "Non spécifié";
        switch ($this->parcours)
        {
            case 'SLAM':
                $libelle = 'Solutions Logicielles et Applications Métiers';
                break;
            case 'SISR':
                $libelle = 'Solutions d’Infrastructure, Systèmes et Réseaux';
                break;
            case 'IND':
                $libelle = 'Indifférencié';
                break;
        }

        return $libelle;
    }
    /**
     * Get parcours
     *
     * @return string
     */
    public function getParcoursNomenclature()
    {
        $libelle = "Non spécifié";
        switch ($this->parcours)
        {
            case 'SLAM':
                $libelle = 'SLAM';
                break;
            case 'SISR':
                $libelle = 'SISR';
                break;
            case 'IND':
                $libelle = 'Indifférencié';
                break;
        }

        return $libelle;
    }
    public function getNumparcours()
    {
        $numparcours = 0;
        switch ($this->parcours)
        {
            case 'SLAM':
                $numparcours = 2;
                break;
            case 'SISR':
                $numparcours = 1;
                break;
            case 'IND':
                $numparcours = 3;
                break;
        }

        return $numparcours;
    }

    /**
     * @return string
     */
    public function getNumexamen()
    {
        return $this->numexamen;
    }

    /**
     * @param string $numexamen
     */
    public function setNumexamen($numexamen)
    {
        $this->numexamen = $numexamen;
    }

    /**
     * @return boolean
     */
    public function isActif()
    {
        return $this->getActif() == 1;
    }
    /**
     * @return int
     */
    public function getActif()
    {
        return $this->actif;
    }

    /**
     * @param int $actif
     */
    public function setActif($actif)
    {
        $this->actif = $actif;
    }

    /**
     * @return int
     */
    public function getSexe()
    {
        return $this->sexe;
    }

    /**
     * @param int $sexe
     */
    public function setSexe($sexe)
    {
        $this->sexe = $sexe;
    }



    /**
     * Returns the username used to authenticate the user.
     * @return string The username
     */
    public function getUsername()
    {
        return $this->getLogin();
    }

    public function isBts()
    {
        return $this->bts;
    }

}
