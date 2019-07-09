<?php


namespace AppBundle\Controller\Prof\Utils;


use AppBundle\Entity\DummyUserLdap;
use AppBundle\Entity\UserLdap;

class UtilisateursVerification
{
    /**
     * tableau clé (login), valeur (UserLdap)
     *
     * @var \Doctrine\Common\Collections\Collection
     */
    private $utilisateurs;

    public function __construct()
    {
        $this->utilisateurs = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getUtilisateurs()
    {
        return $this->utilisateurs;
    }


    /**
     * Ajoute les utilisateurs et créé la listes des stages associés aux utilisateurs
     *
     * @param $utilisateurs UserLdap[]
     * @param $stages \AppBundle\Entity\Stage[]
     * @param $situations \AppBundle\Entity\Situation[]
     */
    public function compute($utilisateurs, $stages, $situations)
    {
        // Fixe les utilisateurs par clé: login
        foreach ($utilisateurs as $utilisateur)
        {
            if (! $this->utilisateurs->containsKey($utilisateur->getLogin())) {
                $this->utilisateurs->set($utilisateur->getLogin(), new UtilisateurVerification($utilisateur));
            }
        }

        // Répartis les stages par utilisateurs
        foreach ($stages as $stage)
        {
            // Obtention de l'objet UtilisateurVerification
            $login = $stage->getLogin();
            $utilisateurVerification = $this->utilisateurs->get($login);
            if ($utilisateurVerification == null)
            {
                $dummyUserLdap = new UserLdap($login, null);
                $dummyUserLdap->setNom("");
                $dummyUserLdap->setPrenom("Non inscrit au BTS ou inactif : "  . $login);

                $utilisateurVerification = new UtilisateurVerification($dummyUserLdap);
                $this->utilisateurs->set($login, $utilisateurVerification);
            }

            // Ajout du stage
            $utilisateurVerification->addStage();
        }

        // Répartis les situations par utilisateurs
        foreach ($situations as $situation)
        {
            // Obtention de l'objet UtilisateurVerification
            $login = $situation->getLogin();

            $utilisateurVerification = $this->utilisateurs->get($login);
            if ($utilisateurVerification == null)
            {
                $dummyUserLdap = new UserLdap($login, null);
                $dummyUserLdap->setNom("");
                $dummyUserLdap->setPrenom("Non inscrit au BTS ou inactif : "  . $login);

                $utilisateurVerification = new UtilisateurVerification($dummyUserLdap);
                $this->utilisateurs->set($login, $utilisateurVerification);
            }

            // Ajout de la situation
            $utilisateurVerification->addSituation();
        }
    }

}