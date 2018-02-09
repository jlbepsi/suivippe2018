<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 23/01/18
 * Time: 11:06
 */

namespace AppBundle\Manager;

class SyntheseBuilder
{
    private $utilisateur;
    private $activitesDomaine;
    private $arrayProcessus;
    private $typologies;
    private $situations;
    private $stages;

    public function addActivitesDomaine($activitesDomaine)
    {
        $this->activitesDomaine = $activitesDomaine;

        $arrayProcessus = array();
        $idProcessus = 0;
        // on compte le nombre de processus
        foreach ($activitesDomaine as $item) {
            $processus = $item->getIdactivite()->getIddomaine()->getIdprocessus();
            if ($processus->getId() == $idProcessus) {
                $arrayProcessus[$idProcessus]['count'] = intval($arrayProcessus[$idProcessus]['count']) +1;
                //$arrayProcessus[$idProcessus]['activites'][] = $item->getIdactivite();
            } else {
                $idProcessus = $processus->getId();

                //$activiteArray = array($item->getIdactivite());
                $arrayProcessus[$processus->getId()] = array(
                    'id' => $processus->getId(),
                    'libelle' => $processus->getNomenclature() . ' ' . $processus->getLibelle(),
                    'count' => 1
                    //,'activites' => $activiteArray
                );
            }
        }
        $this->arrayProcessus = $arrayProcessus;
    }
    public function getActivitesDomaine()
    {
        return $this->activitesDomaine;
    }
    public function getProcessus()
    {
        return $this->arrayProcessus;
    }

    public function addTypologies($typologies)
    {
        $this->typologies = $typologies;
    }
    public function getTypologies()
    {
        return $this->typologies;
    }

    public function addSituations($situations)
    {
        $this->situations = $situations;
        $this->buildSituationActiviteCites();
    }
    public function getSituations()
    {
        return $this->situations;
    }

    public function buildSituationActiviteCites()
    {
        $arraySituationActiviteCites = array();
        foreach ($this->activitesDomaine as $evalue)
        {
            $arraySituationActiviteCites[$evalue->getIdactivite()->getId()] = array(
                'id' => $evalue->getIdactivite()->getId(),
                'e6' => ($evalue->getIdepreuve()->getId()==3 ? true : false),
                'present' => " "
            );
        }

        foreach ($this->situations as $situation)
        {
            $newArraySituationActiviteCites = $arraySituationActiviteCites;
            foreach ($situation->getIdactivite() as $activite)
            {
                if (array_key_exists($activite->getId(), $arraySituationActiviteCites)) {
                    $newArraySituationActiviteCites[$activite->getId()]["present"] = 'X';
                }
            }
            $situation->setArraySituationActiviteCites($newArraySituationActiviteCites);
        }
    }

    public function setUtilisateur($user)
    {
        $this->utilisateur = $user;
    }
    public function getUtilisateur()
    {
        return $this->utilisateur;
    }

    public function addStagesIntitules($stagesIntitules)
    {
        $arrayStageActiviteCites = array();
        foreach ($this->activitesDomaine as $evalue)
        {
            $arrayStageActiviteCites[$evalue->getIdactivite()->getId()] = array(
                'id' => $evalue->getIdactivite()->getId(),
                'e6' => ($evalue->getIdepreuve()->getId()==3 ? true : false),
                'present' => " "
            );
        }

        $allStages = array();
        foreach ($stagesIntitules as $stageintitule) {
            $idStage = $stageintitule->getIdstage()->getId();
            if (! array_key_exists($idStage, $allStages)) {
                $allStages[$idStage] = array(
                    "stage" => $stageintitule->getIdstage(),
                    "annee" => $stageintitule->getIdstage()->getAnnee(),
                    "activites" => array()
                );
            }

            foreach ($stageintitule->getIdactivite() as $activite) {
                $allStages[$idStage]["activites"][] = $activite->getId();
            }
        }

        $this->stages = array();

        $this->stages[1] = array();
        $this->stages[2] = array();

        foreach ($allStages as $stageArray)
        {
            $newArrayStageActiviteCites = $arrayStageActiviteCites;
            foreach ($stageArray["activites"] as $idActivite) {
                if (array_key_exists($idActivite, $newArrayStageActiviteCites)) {
                    $newArrayStageActiviteCites[$idActivite]["present"] = 'X';
                }
            }
            $stageArray["stage"]->setArrayStageActiviteCites($newArrayStageActiviteCites);

            $this->stages[$stageArray["stage"]->getAnnee()][] = $stageArray["stage"];
        }
    }
    public function getStages($annee)
    {

        return $this->stages[$annee];
    }
}