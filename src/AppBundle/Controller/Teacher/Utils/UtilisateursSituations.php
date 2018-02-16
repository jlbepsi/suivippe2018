<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 15/02/18
 * Time: 10:22
 */

namespace AppBundle\Controller\Teacher\Utils;

use AppBundle\Controller\Teacher\Utils\UtilisateurSituations;

class UtilisateursSituations
{
    private $utilisateurs = array();

    /**
     * @return mixed
     */
    public function getUtilisateurs()
    {
        return $this->utilisateurs;
    }

    /**
     * UtilisateursSituations constructor.
     * @param  \Doctrine\Common\Collections\Collection $situation
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
}