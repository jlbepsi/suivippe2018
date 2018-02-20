<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 15/02/18
 * Time: 10:22
 */

namespace AppBundle\Controller\Prof\Utils;

use AppBundle\Controller\Prof\Utils\UtilisateurSituations;

class UtilisateursSituations
{
    /**
     * @var UtilisateurSituations[]
     */
    private $utilisateurs = array();

    /**
     * @return UtilisateurSituations[]
     */
    public function getUtilisateurs()
    {
        return $this->utilisateurs;
    }

    /**
     * @param $situations \AppBundle\Entity\Situation[]
     */
    public function setSituations($situations)
    {
        $count = count($situations);
        $i = 0;
        while ($i < $count)
        {
            $situation = $situations[$i];
            $loginUtilisateur = $situation->getLogin()->getLogin();

            $utilisateurSituations = new UtilisateurSituations();
            $utilisateurSituations->setUtilisateur($situation->getLogin());

            while ($i < $count && $situations[$i]->getLogin()->getLogin() == $loginUtilisateur)
            {
                $utilisateurSituations->addSituation($situations[$i]);
                $i++;
            }

            $this->utilisateurs[] = $utilisateurSituations;
        }
    }

    /**
     * @param $utilisateurs \AppBundle\Entity\Utilisateur[]
     */
    public function setUtilisateursSansSituation($utilisateurs)
    {
        foreach ($utilisateurs as $utilisateur)
        {
            if (! $this->findLogin($utilisateur->getLogin()))
            {
                // Ajoute l'utilisateur sans situations
                $utilisateurSituations = new UtilisateurSituations();
                $utilisateurSituations->setUtilisateur($utilisateur);
                $this->utilisateurs[] = $utilisateurSituations;
            }
        }
    }

    /**
     * @param $login string
     * @return bool
     */
    private function findLogin($login)
    {
        foreach ($this->utilisateurs as $utilisateurSituations)
        {
            if ($utilisateurSituations->getUtilisateur()->getLogin() === $login)
                return true;
        }
        return false;
    }
}