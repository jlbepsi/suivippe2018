<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Stageintituleactivite
 *
 * @ORM\Table(name="stageintituleactivite", indexes={@ORM\Index(name="IDX_37AB326AD5B8D07464CA0FFD", columns={"idStage", "idIntitule"}), @ORM\Index(name="IDX_37AB326AEBD67F4E", columns={"idActivite"})})
 * @ORM\Entity(repositoryClass="AppBundle\Entity\StageintituleactiviteRepository")
 */
class Stageintituleactivite
{
    /**
     * @var integer
     *
     * @ORM\Column(name="idStage", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="NONE")
     */
    private $idstage;

    /**
     * @var integer
     *
     * @ORM\Column(name="idIntitule", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="NONE")
     */
    private $idintitule;

    /**
     * @var \AppBundle\Entity\Activite
     *
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="NONE")
     * @ORM\OneToOne(targetEntity="Activite")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="idActivite", referencedColumnName="id")
     * })
     */
    private $idactivite;



    /**
     * Set idstage
     *
     * @param integer $idstage
     *
     * @return Stageintituleactivite
     */
    public function setIdstage($idstage)
    {
        $this->idstage = $idstage;

        return $this;
    }

    /**
     * Get idstage
     *
     * @return integer
     */
    public function getIdstage()
    {
        return $this->idstage;
    }

    /**
     * Set idintitule
     *
     * @param integer $idintitule
     *
     * @return Stageintituleactivite
     */
    public function setIdintitule($idintitule)
    {
        $this->idintitule = $idintitule;

        return $this;
    }

    /**
     * Get idintitule
     *
     * @return integer
     */
    public function getIdintitule()
    {
        return $this->idintitule;
    }

    /**
     * Set idactivite
     *
     * @param \AppBundle\Entity\Activite $idactivite
     *
     * @return Stageintituleactivite
     */
    public function setIdactivite(\AppBundle\Entity\Activite $idactivite)
    {
        $this->idactivite = $idactivite;

        return $this;
    }

    /**
     * Get idactivite
     *
     * @return \AppBundle\Entity\Activite
     */
    public function getIdactivite()
    {
        return $this->idactivite;
    }
}
