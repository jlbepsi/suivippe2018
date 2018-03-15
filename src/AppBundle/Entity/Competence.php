<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Competence
 *
 * @ORM\Table(name="competence", indexes={@ORM\Index(name="FK_Competence_Activite", columns={"idActivite"})})
 * @ORM\Entity(repositoryClass="AppBundle\Entity\CompetenceRepository")
 */
class Competence
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="nomenclature", type="string", length=12, nullable=false)
     */
    private $nomenclature;

    /**
     * @var string
     *
     * @ORM\Column(name="libelle", type="string", length=250, nullable=false)
     */
    private $libelle;

    /**
     * @var \AppBundle\Entity\Activite
     *
     * @ORM\ManyToOne(targetEntity="Activite")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="idActivite", referencedColumnName="id")
     * })
     */
    private $idactivite;



    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set nomenclature
     *
     * @param string $nomenclature
     * @return Competence
     */
    public function setNomenclature($nomenclature)
    {
        $this->nomenclature = $nomenclature;

        return $this;
    }

    /**
     * Get nomenclature
     *
     * @return string 
     */
    public function getNomenclature()
    {
        return $this->nomenclature;
    }

    /**
     * Set libelle
     *
     * @param string $libelle
     * @return Competence
     */
    public function setLibelle($libelle)
    {
        $this->libelle = $libelle;

        return $this;
    }

    /**
     * Get libelle
     *
     * @return string 
     */
    public function getLibelle()
    {
        return $this->libelle;
    }

    /**
     * Set idactivite
     *
     * @param \AppBundle\Entity\Activite $idactivite
     * @return Competence
     */
    public function setIdactivite(\AppBundle\Entity\Activite $idactivite = null)
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
