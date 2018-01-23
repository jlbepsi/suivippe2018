<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Evalue
 *
 * @ORM\Table(name="evalue", indexes={@ORM\Index(name="idEpreuve", columns={"idEpreuve"}), @ORM\Index(name="idActivite", columns={"idActivite"}), @ORM\Index(name="IDX_32AE9063CA12F4B8", columns={"idParcours"})})
 * @ORM\Entity
 */
class Evalue
{
    /**
     * @var \AppBundle\Entity\Parcours
     *
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="NONE")
     * @ORM\OneToOne(targetEntity="Parcours")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="idParcours", referencedColumnName="id")
     * })
     */
    private $idparcours;

    /**
     * @var \AppBundle\Entity\Epreuve
     *
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="NONE")
     * @ORM\OneToOne(targetEntity="Epreuve")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="idEpreuve", referencedColumnName="id")
     * })
     */
    private $idepreuve;

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
     * Set idparcours
     *
     * @param \AppBundle\Entity\Parcours $idparcours
     *
     * @return Evalue
     */
    public function setIdparcours(\AppBundle\Entity\Parcours $idparcours)
    {
        $this->idparcours = $idparcours;

        return $this;
    }

    /**
     * Get idparcours
     *
     * @return \AppBundle\Entity\Parcours
     */
    public function getIdparcours()
    {
        return $this->idparcours;
    }

    /**
     * Set idepreuve
     *
     * @param \AppBundle\Entity\Epreuve $idepreuve
     *
     * @return Evalue
     */
    public function setIdepreuve(\AppBundle\Entity\Epreuve $idepreuve)
    {
        $this->idepreuve = $idepreuve;

        return $this;
    }

    /**
     * Get idepreuve
     *
     * @return \AppBundle\Entity\Epreuve
     */
    public function getIdepreuve()
    {
        return $this->idepreuve;
    }

    /**
     * Set idactivite
     *
     * @param \AppBundle\Entity\Activite $idactivite
     *
     * @return Evalue
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
