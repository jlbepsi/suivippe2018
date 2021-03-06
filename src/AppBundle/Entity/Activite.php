<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Activite
 *
 * @ORM\Table(name="activite", indexes={@ORM\Index(name="idDomaine", columns={"idDomaine"})})
 * @ORM\Entity
 */
class Activite
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
     * @var integer
     *
     * @ORM\Column(name="lngutile", type="integer", nullable=false)
     */
    private $lngutile;

    /**
     * @var string
     *
     * @ORM\Column(name="libelle", type="string", length=250, nullable=false)
     */
    private $libelle;

    /**
     * @var \AppBundle\Entity\Domaine
     *
     * @ORM\ManyToOne(targetEntity="Domaine")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="idDomaine", referencedColumnName="id")
     * })
     */
    private $iddomaine;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Situation", inversedBy="idactivite")
     * @ORM\JoinTable(name="activitecitee",
     *   joinColumns={
     *     @ORM\JoinColumn(name="idActivite", referencedColumnName="id")
     *   },
     *   inverseJoinColumns={
     *     @ORM\JoinColumn(name="refSituation", referencedColumnName="reference")
     *   }
     * )
     */
    private $refsituation;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->refsituation = new \Doctrine\Common\Collections\ArrayCollection();
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
     *
     * @return Activite
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
     * Set lngutile
     *
     * @param integer $lngutile
     *
     * @return Activite
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
     * @return Activite
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
     * Set iddomaine
     *
     * @param \AppBundle\Entity\Domaine $iddomaine
     *
     * @return Activite
     */
    public function setIddomaine(\AppBundle\Entity\Domaine $iddomaine = null)
    {
        $this->iddomaine = $iddomaine;

        return $this;
    }

    /**
     * Get iddomaine
     *
     * @return \AppBundle\Entity\Domaine
     */
    public function getIddomaine()
    {
        return $this->iddomaine;
    }

    /**
     * Get situation referenced
     *
     * @return bool
     */
    public function isSituationReferenced($situationId)
    {
        $exists =  $this->refsituation->exists(function($key, $element) use ($situationId){
            return $element->getReference() == $situationId;
        }
        );
        return $exists;
    }

    /**
     * Add refsituation
     *
     * @param \AppBundle\Entity\Situation $refsituation
     *
     * @return Activite
     */
    public function addRefsituation(\AppBundle\Entity\Situation $refsituation)
    {
        //$this->refsituation[] = $refsituation;
        if (!$this->refsituation->contains($refsituation)) {
            $this->refsituation->add($refsituation);
        }

        return $this;
    }

    /**
     * Remove refsituation
     *
     * @param \AppBundle\Entity\Situation $refsituation
     */
    public function removeRefsituation(\AppBundle\Entity\Situation $refsituation)
    {
        $this->refsituation->removeElement($refsituation);
    }

    /**
     * Get refsituation
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getRefsituation()
    {
        return $this->refsituation;
    }
}
