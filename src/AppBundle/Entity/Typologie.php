<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Typologie
 *
 * @ORM\Table(name="typologie")
 * @ORM\Entity
 */
class Typologie
{
    /**
     * @var integer
     *
     * @ORM\Column(name="code", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    private $code;

    /**
     * @var integer
     *
     * @ORM\Column(name="lngutile", type="integer", nullable=false)
     */
    private $lngutile;

    /**
     * @var string
     *
     * @ORM\Column(name="libelle", type="string", length=100, nullable=false)
     */
    private $libelle;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Situation", mappedBy="code")
     */
    private $reference;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Stage", mappedBy="code")
     */
    private $idstage;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->reference = new \Doctrine\Common\Collections\ArrayCollection();
        $this->idstage = new \Doctrine\Common\Collections\ArrayCollection();
    }


    /**
     * Get code
     *
     * @return integer
     */
    public function getCode()
    {
        return $this->code;
    }

    /**
     * Set lngutile
     *
     * @param integer $lngutile
     *
     * @return Typologie
     */
    public function setLngutile($lngutile)
    {
        $this->lngutile = $lngutile;

        return $this;
    }

    /**
     * Get lngutile
     *
     * @return integer
     */
    public function getLngutile()
    {
        return $this->lngutile;
    }

    /**
     * Set libelle
     *
     * @param string $libelle
     *
     * @return Typologie
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
     * Get libelle court
     *
     * @return string
     */
    public function getLibelleCourt()
    {
        return substr($this->libelle, 0, $this->lngutile);
    }

    /**
     * Add reference
     *
     * @param \AppBundle\Entity\Situation $reference
     *
     * @return Typologie
     */
    public function addReference(\AppBundle\Entity\Situation $reference)
    {
        $this->reference[] = $reference;

        return $this;
    }

    /**
     * Remove reference
     *
     * @param \AppBundle\Entity\Situation $reference
     */
    public function removeReference(\AppBundle\Entity\Situation $reference)
    {
        $this->reference->removeElement($reference);
    }

    /**
     * Get reference
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getReference()
    {
        return $this->reference;
    }

    /**
     * Add idstage
     *
     * @param \AppBundle\Entity\Stage $idstage
     *
     * @return Typologie
     */
    public function addIdstage(\AppBundle\Entity\Stage $idstage)
    {
        $this->idstage[] = $idstage;

        return $this;
    }

    /**
     * Remove idstage
     *
     * @param \AppBundle\Entity\Stage $idstage
     */
    public function removeIdstage(\AppBundle\Entity\Stage $idstage)
    {
        $this->idstage->removeElement($idstage);
    }

    /**
     * Get idstage
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getIdstage()
    {
        return $this->idstage;
    }
}
