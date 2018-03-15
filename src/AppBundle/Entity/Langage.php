<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Langage
 *
 * @ORM\Table(name="langage")
 * @ORM\Entity
 */
class Langage
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
     * @ORM\Column(name="libelle", type="string", length=100, nullable=false)
     */
    private $libelle;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Framework", inversedBy="idlangage")
     * @ORM\JoinTable(name="langageframework",
     *   joinColumns={
     *     @ORM\JoinColumn(name="idlangage", referencedColumnName="id")
     *   },
     *   inverseJoinColumns={
     *     @ORM\JoinColumn(name="idframework", referencedColumnName="id")
     *   }
     * )
     */
    private $idframework;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->idframework = new \Doctrine\Common\Collections\ArrayCollection();
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
     * @return Langage
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
     * Add idframework
     *
     * @param \AppBundle\Entity\Framework $idframework
     *
     * @return Langage
     */
    public function addIdframework(\AppBundle\Entity\Framework $idframework)
    {
        //$this->idframework[] = $idframework;
        if (!$this->idframework->contains($idframework)) {
            $this->idframework->add($idframework);
        }

        return $this;
    }

    /**
     * Remove idframework
     *
     * @param \AppBundle\Entity\Framework $idframework
     */
    public function removeIdframework(\AppBundle\Entity\Framework $idframework)
    {
        $this->idframework->removeElement($idframework);
    }

    /**
     * Get idframework
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getIdframework()
    {
        return $this->idframework;
    }
}
