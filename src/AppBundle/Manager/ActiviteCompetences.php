<?php
/**
 * Created by PhpStorm.
 * User: epsi
 * Date: 06/12/17
 * Time: 16:07
 */

namespace AppBundle\Manager;


use AppBundle\Entity\Activite;
use AppBundle\Entity\Competence;

class ActiviteCompetences
{
    private $competences;
    private $activite;
    private $login;

    public function __construct($login, Activite $activite)
    {
        $this->competences = array();
        $this->activite = $activite;
        $this->login = $login;
    }

    public function addCompetence(Competence $competence)
    {
        $this->competences[] = $competence;
    }

    public function getCompetences()
    {
        return $this->competences;
    }

    public function getIdActivite()
    {
        return $this->activite->getId();
    }

    public function getActivite()
    {
        return $this->activite;
    }

    public function getReferenced()
    {
        $found = 0;
        foreach ($this->activite->getRefsituation() as $situation)
        {
            if ($situation->getLogin()->getLogin() == $this->login)
            {
                $found++;
            }
        }
        return $found;
    }
}