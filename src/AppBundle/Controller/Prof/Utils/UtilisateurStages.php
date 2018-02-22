<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 15/02/18
 * Time: 12:07
 */

namespace AppBundle\Controller\Prof\Utils;


use AppBundle\Entity\Stage;
use AppBundle\Entity\Utilisateur;

class UtilisateurStages
{
    /**
     * @var \AppBundle\Entity\Stage[]
     */
    private $stages = array();
    /**
     * @var \AppBundle\Entity\Utilisateur
     */
    private $utilisateur;

    /**
     * @return \AppBundle\Entity\Utilisateur
     */
    public function getUtilisateur()
    {
        return $this->utilisateur;
    }

    /**
     * @param \AppBundle\Entity\Utilisateur $utilisateur
     */
    public function setUtilisateur(Utilisateur $utilisateur)
    {
        $this->utilisateur = $utilisateur;
    }

    /**
     * @return \AppBundle\Entity\Stage[]
     */
    public function getStages()
    {
        return $this->stages;
    }

    /**
     * @param $id integer
     * @return \AppBundle\Entity\Stage|null
     */
    public function getStage($id)
    {
        foreach ($this->stages as $stage)
        {
            if ($stage->getId() == $id)
                return $stage;
        }
        return null;
    }

    /**
     * @param $stages \AppBundle\Entity\Stage[]
     */
    public function setStage($stages)
    {
        $this->stages = $stages;
    }

    /**
     * @param \AppBundle\Entity\Stage $stage
     */
    public function addStage(Stage $stage)
    {
        $this->stages[] = $stage;
    }

    public function verifierStage()
    {
        $recommandations = null;
        if (count($this->stages) > 0) {
            $recommandations = array();
            $stageVide = false;
            foreach ($this->stages as $stage) {
                $arrayIntitulesActivites = $stage->getArrayIntitulesActivites();
                if ($arrayIntitulesActivites == null)
                {
                    $stageVide = true;
                }
                else
                {
                    $nbIntitules = count($arrayIntitulesActivites);
                    if ($nbIntitules < 3)
                        $recommandations[] = "Un stage doit avoir au moins 3 intitulés";
                    foreach ($arrayIntitulesActivites as $intitulesActivite) {
                        if ($intitulesActivite["nbActivite"] < 4) {
                            $recommandations[] = "Un stage doit avoir au moins 4 activités pour chaque intitulé";
                            break;
                        }
                    }
                }
            }
            if ($stageVide)
                array_unshift($recommandations, "Un stage doit avoir des intitulés et activités");
        }

        return $recommandations;
    }

    public function countStagesIncomplets()
    {
        $nbStagesActivitesIncomplets = 0;

        if (count($this->stages) > 0) {
            foreach ($this->stages as $stage) {
                $nbStagesActivitesIncomplets += $stage->analyseActivites();
            }
        }

        return $nbStagesActivitesIncomplets;
    }
}