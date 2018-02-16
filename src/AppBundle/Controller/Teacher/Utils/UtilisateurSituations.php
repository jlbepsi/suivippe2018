<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 15/02/18
 * Time: 12:07
 */

namespace AppBundle\Controller\Teacher\Utils;


use AppBundle\Entity\Situation;
use AppBundle\Entity\Utilisateur;

class UtilisateurSituations
{
    private $situations = array();
    private $utilisateur;

    /**
     * @return Utilisateur
     */
    public function getUtilisateur()
    {
        return $this->utilisateur;
    }

    public function setUtilisateur(Utilisateur $utilisateur)
    {
        $this->utilisateur = $utilisateur;
    }

    /**
     * @return mixed
     */
    public function getSituations()
    {
        return $this->situations;
    }

    public function addSituation(Situation $situation)
    {
        $this->situations[] = $situation;
    }

    public function verifierSituation()
    {
        // Obtention du parcours
        $parcours = $this->getUtilisateur()->getNumparcours()->getNomenclature();
        switch ($parcours)
        {
            case 'SLAM':
                break;
            case 'SISR':
                break;
            default:
                // Pas de recommendations
                break;
        }

        if ($this->getUtilisateur()->getClasse() == 'B2')
        {
            // Il doit y avoir 2 situation E4
        }
    }
}