<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Parcours
 *
 * @ORM\Table(name="parcours")
 * @ORM\Entity
 */
class Parcours
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
     * @ORM\ManyToMany(targetEntity="Processus", inversedBy="idparcours")
     * @ORM\JoinTable(name="exploite",
     *   joinColumns={
     *     @ORM\JoinColumn(name="idParcours", referencedColumnName="id")
     *   },
     *   inverseJoinColumns={
     *     @ORM\JoinColumn(name="idProcessus", referencedColumnName="id")
     *   }
     * )
     */
    private $idprocessus;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->idprocessus = new \Doctrine\Common\Collections\ArrayCollection();
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
     * @return Parcours
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
     * @return Parcours
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
     * Add idprocessus
     *
     * @param \AppBundle\Entity\Processus $idprocessus
     * @return Parcours
     */
    public function addIdprocessus(\AppBundle\Entity\Processus $idprocessus)
    {
        $this->idprocessus[] = $idprocessus;

        return $this;
    }

    /**
     * Remove idprocessus
     *
     * @param \AppBundle\Entity\Processus $idprocessus
     */
    public function removeIdprocessus(\AppBundle\Entity\Processus $idprocessus)
    {
        $this->idprocessus->removeElement($idprocessus);
    }

    /**
     * Get idprocessus
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getIdprocessus()
    {
        return $this->idprocessus;
    }
}
