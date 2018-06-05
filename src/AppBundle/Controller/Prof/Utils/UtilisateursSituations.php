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
     * @var integer
     */
    private $analyseSituationActivite;

    /**
     * @return int
     */
    public function getAnalyseSituationActivite()
    {
        return $this->analyseSituationActivite;
    }

    /**
     * @param int $analyseSituationActivite
     */
    public function setAnalyseSituationActivite($analyseSituationActivite)
    {
        $this->analyseSituationActivite = $analyseSituationActivite;
    }

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
            $utilisateurSituations->setAnalyseSituationActivite($this->analyseSituationActivite);
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
                $utilisateurSituations->setAnalyseSituationActivite($this->analyseSituationActivite);
                $utilisateurSituations->setUtilisateur($utilisateur);
                $this->utilisateurs[] = $utilisateurSituations;
            }
        }
        /*// Tri sur le nom puis prénom
        usort($this->utilisateurs, function($e1, $e2)
        {
            return ($e1->getUtilisateur()->getNom() . ' ' . $e1->getUtilisateur()->getPrenom() >
                    $e2->getUtilisateur()->getNom() . ' ' . $e1->getUtilisateur()->getPrenom());
        });*/
    }

    /**
     * @return array
     */
    public function analyseUtilisateursSituations()
    {
        $cptUtilisateurs = 0;
        $cptSituations = 0;
        $cptSansSituations = 0;
        $cptSituationsIncompletes = 0;

        foreach ($this->utilisateurs as $utilisateur)
        {
            $cptUtilisateurs++;

            $nbSituation = count($utilisateur->getSituations());
            if ($nbSituation == 0) {
                $cptSansSituations++;
            }
            else
            {
                $cptSituationsIncompletes += $utilisateur->countSituationsIncompletes();
                $cptSituations += $nbSituation;
            }
        }

        return array('nbUtilisateurs' => $cptUtilisateurs, 'nbSituations' => $cptSituations, 'nbUtilisateursSansSituation' => $cptSansSituations,
                     'nbSituationsIncompletes' => $cptSituationsIncompletes);
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