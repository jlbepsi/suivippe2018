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
     * @var int
     *
     * @ORM\Column(name="referencee4", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    private $referencee4;

    /**
     * @var int
     *
     * @ORM\Column(name="competenceApplication", type="integer", nullable=false)
     */
    private $competenceapplication = '0';

    /**
     * @var int
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
     * @var int
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
     * Get referencee4.
     *
     * @return int
     */
    public function getReferencee4()
    {
        return $this->referencee4;
    }

    /**
     * Set competenceapplication.
     *
     * @param int $competenceapplication
     *
     * @return Situatione4
     */
    public function setCompetenceapplication($competenceapplication)
    {
        $this->competenceapplication = $competenceapplication;

        return $this;
    }

    /**
     * Get competenceapplication.
     *
     * @return int
     */
    public function getCompetenceapplication()
    {
        return $this->competenceapplication;
    }

    /**
     * Set competencesgbd.
     *
     * @param int $competencesgbd
     *
     * @return Situatione4
     */
    public function setCompetencesgbd($competencesgbd)
    {
        $this->competencesgbd = $competencesgbd;

        return $this;
    }

    /**
     * Get competencesgbd.
     *
     * @return int
     */
    public function getCompetencesgbd()
    {
        return $this->competencesgbd;
    }

    /**
     * Set contexte.
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
     * Get contexte.
     *
     * @return string
     */
    public function getContexte()
    {
        return $this->contexte;
    }

    /**
     * Set intitule.
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
     * Get intitule.
     *
     * @return string
     */
    public function getIntitule()
    {
        return $this->intitule;
    }

    /**
     * Set equipe.
     *
     * @param int $equipe
     *
     * @return Situatione4
     */
    public function setEquipe($equipe)
    {
        $this->equipe = $equipe;

        return $this;
    }

    /**
     * Get equipe.
     *
     * @return int
     */
    public function getEquipe()
    {
        return $this->equipe;
    }

    /**
     * Set realisation.
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
     * Get realisation.
     *
     * @return string
     */
    public function getRealisation()
    {
        return $this->realisation;
    }
}
