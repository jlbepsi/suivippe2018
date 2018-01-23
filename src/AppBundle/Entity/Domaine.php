<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Domaine
 *
 * @ORM\Table(name="domaine", indexes={@ORM\Index(name="FK_Domaine_Processus", columns={"idProcessus"})})
 * @ORM\Entity
 */
class Domaine
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
     * @ORM\Column(name="libelle", type="string", length=200, nullable=false)
     */
    private $libelle;

    /**
     * @var \Processus
     *
     * @ORM\ManyToOne(targetEntity="Processus")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="idProcessus", referencedColumnName="id")
     * })
     */
    private $idprocessus;



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
     * @return Domaine
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
     * @return Domaine
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
     * Set idprocessus
     *
     * @param \AppBundle\Entity\Processus $idprocessus
     * @return Domaine
     */
    public function setIdprocessus(\AppBundle\Entity\Processus $idprocessus = null)
    {
        $this->idprocessus = $idprocessus;

        return $this;
    }

    /**
     * Get idprocessus
     *
     * @return \AppBundle\Entity\Processus 
     */
    public function getIdprocessus()
    {
        return $this->idprocessus;
    }
}
