<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Framework
 *
 * @ORM\Table(name="framework")
 * @ORM\Entity
 */
class Framework
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
     * @ORM\Column(name="libelle", type="string", length=200, nullable=false)
     */
    private $libelle;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Langage", mappedBy="idframework")
     */
    private $idlangage;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->idlangage = new \Doctrine\Common\Collections\ArrayCollection();
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
     * Set libelle
     *
     * @param string $libelle
     *
     * @return Framework
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
     * Add idlangage
     *
     * @param \AppBundle\Entity\Langage $idlangage
     *
     * @return Framework
     */
    public function addIdlangage(\AppBundle\Entity\Langage $idlangage)
    {
        //$this->idlangage[] = $idlangage;
        if (!$this->idlangage->contains($idlangage)) {
            $this->idlangage->add($idlangage);
        }

        return $this;
    }

    /**
     * Remove idlangage
     *
     * @param \AppBundle\Entity\Langage $idlangage
     */
    public function removeIdlangage(\AppBundle\Entity\Langage $idlangage)
    {
        $this->idlangage->removeElement($idlangage);
    }

    /**
     * Get idlangage
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getIdlangage()
    {
        return $this->idlangage;
    }
}
