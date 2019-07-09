<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Commentaire
 *
 * @ORM\Table(name="commentaire", indexes={@ORM\Index(name="FK_Commentaire_Situation", columns={"refSituation"}), @ORM\Index(name="loginProfesseur", columns={"loginProfesseur"})})
 * @ORM\Entity
 */
class Commentaire
{
    /**
     * @var integer
     *
     * @ORM\Column(name="numero", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    private $numero;

    /**
     * @var string
     *
     * @ORM\Column(name="commentaire", type="string", length=200, nullable=true)
     */
    private $commentaire;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="datecommentaire", type="datetime", nullable=true)
     */
    private $datecommentaire;

    /**
     * @var \AppBundle\Entity\Situation
     *
     * @ORM\ManyToOne(targetEntity="Situation")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="refSituation", referencedColumnName="reference")
     * })
     */
    private $refsituation;

    /**
     * @var string
     *
     * @ORM\Column(name="loginprofesseur", type="string", length=30, nullable=false)
     *
     */
    private $loginprofesseur;



    /**
     * Get numero
     *
     * @return integer 
     */
    public function getNumero()
    {
        return $this->numero;
    }

    /**
     * Set commentaire
     *
     * @param string $commentaire
     * @return Commentaire
     */
    public function setCommentaire($commentaire)
    {
        $this->commentaire = $commentaire;

        return $this;
    }

    /**
     * Get commentaire
     *
     * @return string 
     */
    public function getCommentaire()
    {
        return $this->commentaire;
    }

    /**
     * Set datecommentaire
     *
     * @param \DateTime $datecommentaire
     * @return Commentaire
     */
    public function setDatecommentaire($datecommentaire)
    {
        $this->datecommentaire = $datecommentaire;

        return $this;
    }

    /**
     * Get datecommentaire
     *
     * @return \DateTime 
     */
    public function getDatecommentaire()
    {
        return $this->datecommentaire;
    }

    /**
     * Set refsituation
     *
     * @param \AppBundle\Entity\Situation $refsituation
     * @return Commentaire
     */
    public function setRefsituation(\AppBundle\Entity\Situation $refsituation = null)
    {
        $this->refsituation = $refsituation;

        return $this;
    }

    /**
     * Get refsituation
     *
     * @return \AppBundle\Entity\Situation 
     */
    public function getRefsituation()
    {
        return $this->refsituation;
    }

    /**
     * Set loginprofesseur
     *
     * @param string $loginprofesseur
     * @return Commentaire
     */
    public function setLoginprofesseur($loginprofesseur)
    {
        $this->loginprofesseur = $loginprofesseur;

        return $this;
    }

    /**
     * Get loginprofesseur
     *
     * @return string
     */
    public function getLoginprofesseur()
    {
        return $this->loginprofesseur;
    }
}
