<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 15/02/18
 * Time: 12:07
 */

namespace AppBundle\Controller\Prof\Utils;


use AppBundle\Entity\Stage;
use AppBundle\Entity\UserLdap;

class UtilisateurStages
{
    /**
     * @var \AppBundle\Entity\Stage[]
     */
    private $stages = array();
    /**
     * @var UserLdap
     */
    private $utilisateur;


    /**
     * UtilisateurStages constructor.
     * @param UserLdap|null $utilisateur
     */
    public function __construct(UserLdap $utilisateur = null)
    {
        $this->utilisateur = $utilisateur;
    }


    /**
     * @return UserLdap
     */
    public function getUtilisateur()
    {
        return $this->utilisateur;
    }

    /**
     * @return \AppBundle\Entity\Stage[]
     */
    public function getStages()
    {
        return $this->stages;
    }

    /**
     * @param $stages \AppBundle\Entity\Stage[]
     */
    public function setStage($stages)
    {
        $this->stages = $stages;
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
                        if ($intitulesActivite["nbActivite"] < 2) {
                            $recommandations[] = "Un stage doit avoir au moins 2 activités pour chaque intitulé";
                            break;
                        }
                    }
                }
            }
            if ($stageVide)
                array_unshift($recommandations, "Un stage doit avoir au moins 3 intitulés et  2 activités pour chaque intitulé");
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