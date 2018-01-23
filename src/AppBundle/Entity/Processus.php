<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Processus
 *
 * @ORM\Table(name="processus")
 * @ORM\Entity
 */
class Processus
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
     * @ORM\Column(name="nomenclature", type="string", length=6, nullable=false)
     */
    private $nomenclature;

    /**
     * @var string
     *
     * @ORM\Column(name="libelle", type="string", length=200, nullable=false)
     */
    private $libelle;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Parcours", mappedBy="idprocessus")
     */
    private $idparcours;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->idparcours = new \Doctrine\Common\Collections\ArrayCollection();
    }


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
     * @return Processus
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
     * @return Processus
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
     * Add idparcours
     *
     * @param \AppBundle\Entity\Parcours $idparcours
     * @return Processus
     */
    public function addIdparcour(\AppBundle\Entity\Parcours $idparcours)
    {
        $this->idparcours[] = $idparcours;

        return $this;
    }

    /**
     * Remove idparcours
     *
     * @param \AppBundle\Entity\Parcours $idparcours
     */
    public function removeIdparcour(\AppBundle\Entity\Parcours $idparcours)
    {
        $this->idparcours->removeElement($idparcours);
    }

    /**
     * Get idparcours
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getIdparcours()
    {
        return $this->idparcours;
    }

    /**
     * Test if idparcours is present
     *
     * @return bool
     */
    public function isParcoursPresent($parcours)
    {
        $exists =  $this->idparcours->exists(function($key, $element) use ($parcours){
            return $element->getId() == $parcours;
        }
        );
        return $exists;
    }
}
