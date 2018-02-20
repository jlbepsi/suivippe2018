<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 15/02/18
 * Time: 10:22
 */

namespace AppBundle\Controller\Prof\Utils;

use AppBundle\Controller\Prof\Utils\UtilisateurStages;
use AppBundle\Entity\Utilisateur;

class UtilisateursStages
{
    /**
     * @var UtilisateurStages[]
     */
    private $utilisateurs = array();

    /**
     * @return UtilisateurStages[]
     */
    public function getUtilisateurs()
    {
        return $this->utilisateurs;
    }

    /**
     * @param $stages \AppBundle\Entity\Stage[]
     */
    public function setStages($stages)
    {
        $count = count($stages);
        $i = 0;
        while ($i < $count)
        {
            $stage = $stages[$i];
            $loginUtilisateur = $stage->getLogin()->getLogin();

            $utilisateurStages = new UtilisateurStages();
            $utilisateurStages->setUtilisateur($stage->getLogin());

            while ($i < $count && $stages[$i]->getLogin()->getLogin() == $loginUtilisateur)
            {
                $utilisateurStages->addStage($stages[$i]);
                $i++;
            }

            $this->utilisateurs[] = $utilisateurStages;
        }
    }

    /**
     * @param $utilisateurs \AppBundle\Entity\Utilisateur[]
     */
    public function setUtilisateursSansStage($utilisateurs)
    {
        foreach ($utilisateurs as $utilisateur)
        {
            if ($this->findUtilisateur($utilisateur->getLogin()) == null)
            {
                // Ajoute l'utilisateur sans stages
                $utilisateurStages = new UtilisateurStages();
                $utilisateurStages->setUtilisateur($utilisateur);
                $this->utilisateurs[] = $utilisateurStages;
            }
        }
    }

    /**
     * @param $login string
     * @return UtilisateurStages|null
     */
    private function findUtilisateur($login)
    {
        foreach ($this->utilisateurs as $utilisateurStages)
        {
            if ($utilisateurStages->getUtilisateur()->getLogin() === $login)
                return $utilisateurStages;
        }
        return null;
    }

    /**
     * @param $stagesIntitule \AppBundle\Entity\Stageintitule
     */
    public function addStageIntitule($stagesIntitule)
    {
        // On recherche le stage d'après l'utilisateur
        $utilisateurStages = $this->findUtilisateur($stagesIntitule->getIdstage()->getLogin()->getLogin());
        if ($utilisateurStages)
        {
            $stage = $utilisateurStages->getStage($stagesIntitule->getIdstage()->getId());
            if ($stage)
            {
                $stage->addIntitulesActivites($stagesIntitule);
            }
        }
    }
}