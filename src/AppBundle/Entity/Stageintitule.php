<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Stageintitule
 *
 * @ORM\Table(name="stageintitule", indexes={@ORM\Index(name="IDX_C9D88496D5B8D074", columns={"idStage"})})
 * @ORM\Entity(repositoryClass="AppBundle\Entity\StageintituleRepository")
 */
class Stageintitule
{
    /**
     * @var integer
     *
     * @ORM\Column(name="idIntitule", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="NONE")
     */
    private $idintitule;

    /**
     * @var string
     *
     * @ORM\Column(name="intitule", type="string", length=150, nullable=false)
     */
    private $intitule;

    /**
     * @var \AppBundle\Entity\Stage
     *
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="NONE")
     * @ORM\OneToOne(targetEntity="Stage")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="idStage", referencedColumnName="id")
     * })
     */
    private $idstage;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Activite", inversedBy="idstage")
     * @ORM\JoinTable(name="stageintituleactivite",
     *   joinColumns={
     *     @ORM\JoinColumn(name="idStage", referencedColumnName="idStage"),
     *     @ORM\JoinColumn(name="idIntitule", referencedColumnName="idIntitule")
     *   },
     *   inverseJoinColumns={
     *     @ORM\JoinColumn(name="idActivite", referencedColumnName="id")
     *   }
     * )
     */
    private $idactivite;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->idactivite = new \Doctrine\Common\Collections\ArrayCollection();
    }


    /**
     * Set idintitule
     *
     * @param integer $idintitule
     * @return Stageintitule
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
     * Set intitule
     *
     * @param string $intitule
     * @return Stageintitule
     */
    public function setIntitule($intitule)
    {
        $this->intitule = $intitule;

        return $this;
    }

    /**
     * Get intitule
     *
     * @return string 
     */
    public function getIntitule()
    {
        return $this->intitule;
    }

    /**
     * Set idstage
     *
     * @param \AppBundle\Entity\Stage $idstage
     * @return Stageintitule
     */
    public function setIdstage(\AppBundle\Entity\Stage $idstage)
    {
        $this->idstage = $idstage;

        return $this;
    }

    /**
     * Get idstage
     *
     * @return \AppBundle\Entity\Stage 
     */
    public function getIdstage()
    {
        return $this->idstage;
    }

    /**
     * Add idactivite
     *
     * @param \AppBundle\Entity\Activite $idactivite
     * @return Stageintitule
     */
    public function addIdactivite(\AppBundle\Entity\Activite $idactivite)
    {
        //$this->idactivite[] = $idactivite;
        if (!$this->idactivite->contains($idactivite)) {
            $this->idactivite->add($idactivite);
        }


        return $this;
    }

    /**
     * Remove idactivite
     *
     * @param \AppBundle\Entity\Activite $idactivite
     */
    public function removeIdactivite(\AppBundle\Entity\Activite $idactivite)
    {
        $this->idactivite->removeElement($idactivite);
    }

    /**
     * Remove all idactivite
     *
     */
    public function removeAllIdactivite()
    {
        $this->idactivite->clear();
    }

    /**
     * Get idactivite
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getIdactivite()
    {
        return $this->idactivite;
    }

    /**
     * Test if code is present
     *
     * @return bool
     */
    public function activiteReferenced($id)
    {
        $exists =  $this->idactivite->exists(function($key, $element) use ($id){
            return $element->getId() == $id;
        }
        );
        return $exists;
    }
}
