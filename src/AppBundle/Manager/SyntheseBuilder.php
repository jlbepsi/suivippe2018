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
            $arraySituationActiviteCites[$evalue->getIdactivite()->getid()] = array(
                'id' => $evalue->getIdactivite()->getid(),
                'e6' => ($evalue->getIdepreuve()->getid()==3 ? true : false),
                'present' => ' '
            );
        }

        foreach ($this->situations as $situation)
        {
            $newArraySituationActiviteCites = $arraySituationActiviteCites;
            foreach ($situation->getIdactivite() as $activite)
            {
                $newArraySituationActiviteCites[$activite->getId()]["present"] = 'X';
            }
            $situation->setArraySituationActiviteCites($newArraySituationActiviteCites);
        }
    }

    public function getUtilisateur()
    {
        return $this->utilisateur;
    }
    public function setUtilisateur($user)
    {
        $this->utilisateur = $user;
    }
}