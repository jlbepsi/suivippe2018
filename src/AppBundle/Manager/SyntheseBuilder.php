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
    private $stagesIntitules;

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
        $this->stagesIntitules = array();

        $this->stagesIntitules[1] = array();
        $this->stagesIntitules[2] = array();

        // Répartition des stages sur les 2 ans
        foreach ($stagesIntitules as $stageintitule) {
            if ($stageintitule->getIdstage()->getAnnee() == 1) {
                $this->stagesIntitules[1][] = $stageintitule;
            }
            else{
                $this->stagesIntitules[2][] = $stageintitule;
            }
        }

        $this->buildStageActiviteCites();
    }
    public function buildStageActiviteCites()
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

        foreach ($this->stagesIntitules as $stageIntituleAnnee)
        {
            foreach ($stageIntituleAnnee as $stageintitule)
            {
                $newArrayStageActiviteCites = $arrayStageActiviteCites;
                foreach ($stageintitule->getIdactivite() as $activite) {
                    if (array_key_exists($activite->getId(), $arrayStageActiviteCites)) {
                        $newArrayStageActiviteCites[$activite->getId()]["present"] = 'X';
                    }
                }
                $stageintitule->setArrayStageActiviteCites($newArrayStageActiviteCites);
            }
        }
    }
    public function getStagesIntitules($annee)
    {

        return $this->stagesIntitules[$annee];
    }
}