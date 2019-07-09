<?php


namespace AppBundle\Controller\Prof\Utils;


use AppBundle\Entity\UserLdap;

class UtilisateurVerification
{
    /**
     * @var integer
     */
    private $stages = 0;
    /**
     * @var integer
     */
    private $situations = 0;
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
     * @return int
     */
    public function getStages()
    {
        return $this->stages;
    }

    /**
     */
    public function addStage()
    {
        $this->stages++;
    }

    /**
     * @return int
     */
    public function getSituations()
    {
        return $this->situations;
    }

    /**
     */
    public function addSituation()
    {
        $this->situations++;
    }



}