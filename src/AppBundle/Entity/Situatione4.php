<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Situatione4
 *
 * @ORM\Table(name="situatione4")
 * @ORM\Entity
 */
class Situatione4
{
    /**
     * @var integer
     *
     * @ORM\Column(name="referencee4", type="integer", nullable=false)
     * @ORM\Id
     */
    private $referencee4;

    /**
     * @var integer
     *
     * @ORM\Column(name="competenceApplication", type="integer", nullable=false)
     */
    private $competenceapplication = '0';

    /**
     * @var integer
     *
     * @ORM\Column(name="competenceSGBD", type="integer", nullable=false)
     */
    private $competencesgbd = '0';

    /**
     * @var string
     *
     * @ORM\Column(name="contexte", type="string", length=250, nullable=false)
     */
    private $contexte;

    /**
     * @var string
     *
     * @ORM\Column(name="intitule", type="string", length=250, nullable=false)
     */
    private $intitule;

    /**
     * @var integer
     *
     * @ORM\Column(name="equipe", type="integer", nullable=false)
     */
    private $equipe = '0';

    /**
     * @var string
     *
     * @ORM\Column(name="realisation", type="string", length=250, nullable=false)
     */
    private $realisation;



    /**
     * Set referencee4
     *
     * @param integer $referencee4
     *
     * @return Situatione4
     */
    public function setReferencee4($referencee4)
    {
        $this->referencee4 = $referencee4;

        return $this;
    }

    /**
     * Get referencee4
     *
     * @return integer
     */
    public function getReferencee4()
    {
        return $this->referencee4;
    }

    /**
     * Set competenceapplication
     *
     * @param integer $competenceapplication
     *
     * @return Situatione4
     */
    public function setCompetenceapplication($competenceapplication)
    {
        $this->competenceapplication = $competenceapplication;

        return $this;
    }

    /**
     * Get competenceapplication
     *
     * @return integer
     */
    public function getCompetenceapplication()
    {
        return $this->competenceapplication;
    }

    /**
     * Set competencesgbd
     *
     * @param integer $competencesgbd
     *
     * @return Situatione4
     */
    public function setCompetencesgbd($competencesgbd)
    {
        $this->competencesgbd = $competencesgbd;

        return $this;
    }

    /**
     * Get competencesgbd
     *
     * @return integer
     */
    public function getCompetencesgbd()
    {
        return $this->competencesgbd;
    }

    /**
     * Set contexte
     *
     * @param string $contexte
     *
     * @return Situatione4
     */
    public function setContexte($contexte)
    {
        $this->contexte = $contexte;

        return $this;
    }

    /**
     * Get contexte
     *
     * @return string
     */
    public function getContexte()
    {
        return $this->contexte;
    }

    /**
     * Set intitule
     *
     * @param string $intitule
     *
     * @return Situatione4
     */
    public function setIntitule($intitule)
    {
        $this->intitule = $intitule;

        return $this;
    }

    /**
     * Get intitule
     *
     * @return string
     */
    public function getIntitule()
    {
        return $this->intitule;
    }

    /**
     * Set equipe
     *
     * @param integer $equipe
     *
     * @return Situatione4
     */
    public function setEquipe($equipe)
    {
        $this->equipe = $equipe;

        return $this;
    }

    /**
     * Get equipe
     *
     * @return integer
     */
    public function getEquipe()
    {
        return $this->equipe;
    }

    /**
     * Set realisation
     *
     * @param string $realisation
     *
     * @return Situatione4
     */
    public function setRealisation($realisation)
    {
        $this->realisation = $realisation;

        return $this;
    }

    /**
     * Get realisation
     *
     * @return string
     */
    public function getRealisation()
    {
        return $this->realisation;
    }
}
