<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Situation
 *
 * @ORM\Table(name="situation", indexes={@ORM\Index(name="FK_Situation_Cadre", columns={"codeCadre"}), @ORM\Index(name="FK_Situation_Localisation", columns={"codeLocalisation"}), @ORM\Index(name="FK_Situation_Source", columns={"codeLangage"}), @ORM\Index(name="FK_Situation_TypeSituation", columns={"codeFramework"}), @ORM\Index(name="FK_Situation_Utilisateur", columns={"login"}), @ORM\Index(name="codeOS", columns={"codeOS", "codeService"}), @ORM\Index(name="codeService", columns={"codeService"}), @ORM\Index(name="refe4", columns={"refe4"}), @ORM\Index(name="IDX_EC2D9ACA5B1B06D0", columns={"codeOS"})})
 * @ORM\Entity
 */
class Situation
{
    /**
     * @var integer
     *
     * @ORM\Column(name="reference", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    private $reference;

    /**
     * @var string
     *
     * @ORM\Column(name="libelle", type="string", length=80, nullable=false)
     */
    private $libelle;

    /**
     * @var string
     *
     * @ORM\Column(name="descriptif", type="string", length=250, nullable=false)
     */
    private $descriptif;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="datedebut", type="datetime", nullable=true)
     */
    private $datedebut;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="datefin", type="datetime", nullable=true)
     */
    private $datefin;

    /**
     * @var integer
     *
     * @ORM\Column(name="codeLocalisation", type="integer", nullable=true)
     */
    private $codelocalisation;

    /**
     * @var \Utilisateur
     *
     * @ORM\ManyToOne(targetEntity="Utilisateur")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="login", referencedColumnName="login")
     * })
     */
    private $login;

    /**
     * @var \Cadre
     *
     * @ORM\ManyToOne(targetEntity="Cadre")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="codeCadre", referencedColumnName="code")
     * })
     */
    private $codecadre;

    /**
     * @var \Langage
     *
     * @ORM\ManyToOne(targetEntity="Langage")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="codeLangage", referencedColumnName="id")
     * })
     */
    private $codelangage;

    /**
     * @var \Framework
     *
     * @ORM\ManyToOne(targetEntity="Framework")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="codeFramework", referencedColumnName="id")
     * })
     */
    private $codeframework;

    /**
     * @var \Operatingsystem
     *
     * @ORM\ManyToOne(targetEntity="Operatingsystem")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="codeOS", referencedColumnName="id")
     * })
     */
    private $codeos;

    /**
     * @var \Services
     *
     * @ORM\ManyToOne(targetEntity="Services")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="codeService", referencedColumnName="id")
     * })
     */
    private $codeservice;

    /**
     * @var \Situatione4
     *
     * @ORM\ManyToOne(targetEntity="Situatione4")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="refe4", referencedColumnName="referencee4")
     * })
     */
    private $refe4;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Activite", mappedBy="refsituation")
     */
    private $idactivite;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Typologie", inversedBy="reference")
     * @ORM\JoinTable(name="situationtypo",
     *   joinColumns={
     *     @ORM\JoinColumn(name="reference", referencedColumnName="reference")
     *   },
     *   inverseJoinColumns={
     *     @ORM\JoinColumn(name="code", referencedColumnName="code")
     *   }
     * )
     */
    private $code;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->idactivite = new \Doctrine\Common\Collections\ArrayCollection();
        $this->code = new \Doctrine\Common\Collections\ArrayCollection();
    }


    /**
     * Get reference
     *
     * @return integer
     */
    public function getReference()
    {
        return $this->reference;
    }

    /**
     * Set libelle
     *
     * @param string $libelle
     *
     * @return Situation
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
        return substr($this->libelle, 0, 30);
    }

    /**
     * Set descriptif
     *
     * @param string $descriptif
     *
     * @return Situation
     */
    public function setDescriptif($descriptif)
    {
        $this->descriptif = $descriptif;

        return $this;
    }

    /**
     * Get descriptif
     *
     * @return string
     */
    public function getDescriptif()
    {
        return $this->descriptif;
    }

    /**
     * Set datedebut
     *
     * @param \DateTime $datedebut
     *
     * @return Situation
     */
    public function setDatedebut($datedebut)
    {
        $this->datedebut = $datedebut;

        return $this;
    }

    /**
     * Get datedebut
     *
     * @return \DateTime
     */
    public function getDatedebut()
    {
        return $this->datedebut;
    }

    /**
     * Set datefin
     *
     * @param \DateTime $datefin
     *
     * @return Situation
     */
    public function setDatefin($datefin)
    {
        $this->datefin = $datefin;

        return $this;
    }

    /**
     * Get datefin
     *
     * @return \DateTime
     */
    public function getDatefin()
    {
        return $this->datefin;
    }

    /**
     * Set codelocalisation
     *
     * @param integer $codelocalisation
     *
     * @return Situation
     */
    public function setCodelocalisation($codelocalisation)
    {
        $this->codelocalisation = $codelocalisation;

        return $this;
    }

    /**
     * Get codelocalisation
     *
     * @return integer
     */
    public function getCodelocalisation()
    {
        return $this->codelocalisation;
    }

    /**
     * Set login
     *
     * @param \AppBundle\Entity\Utilisateur $login
     *
     * @return Situation
     */
    public function setLogin(\AppBundle\Entity\Utilisateur $login = null)
    {
        $this->login = $login;

        return $this;
    }

    /**
     * Get login
     *
     * @return \AppBundle\Entity\Utilisateur
     */
    public function getLogin()
    {
        return $this->login;
    }

    /**
     * Set codecadre
     *
     * @param \AppBundle\Entity\Cadre $codecadre
     *
     * @return Situation
     */
    public function setCodecadre(\AppBundle\Entity\Cadre $codecadre = null)
    {
        $this->codecadre = $codecadre;

        return $this;
    }

    /**
     * Get codecadre
     *
     * @return \AppBundle\Entity\Cadre
     */
    public function getCodecadre()
    {
        return $this->codecadre;
    }

    /**
     * Set codelangage
     *
     * @param \AppBundle\Entity\Langage $codelangage
     *
     * @return Situation
     */
    public function setCodelangage(\AppBundle\Entity\Langage $codelangage = null)
    {
        $this->codelangage = $codelangage;

        return $this;
    }

    /**
     * Get codelangage
     *
     * @return \AppBundle\Entity\Langage
     */
    public function getCodelangage()
    {
        return $this->codelangage;
    }

    /**
     * Set codeframework
     *
     * @param \AppBundle\Entity\Framework $codeframework
     *
     * @return Situation
     */
    public function setCodeframework(\AppBundle\Entity\Framework $codeframework = null)
    {
        $this->codeframework = $codeframework;

        return $this;
    }

    /**
     * Get codeframework
     *
     * @return \AppBundle\Entity\Framework
     */
    public function getCodeframework()
    {
        return $this->codeframework;
    }

    /**
     * Set codeos
     *
     * @param \AppBundle\Entity\Operatingsystem $codeos
     *
     * @return Situation
     */
    public function setCodeos(\AppBundle\Entity\Operatingsystem $codeos = null)
    {
        $this->codeos = $codeos;

        return $this;
    }

    /**
     * Get codeos
     *
     * @return \AppBundle\Entity\Operatingsystem
     */
    public function getCodeos()
    {
        return $this->codeos;
    }

    /**
     * Set codeservice
     *
     * @param \AppBundle\Entity\Services $codeservice
     *
     * @return Situation
     */
    public function setCodeservice(\AppBundle\Entity\Services $codeservice = null)
    {
        $this->codeservice = $codeservice;

        return $this;
    }

    /**
     * Get codeservice
     *
     * @return \AppBundle\Entity\Services
     */
    public function getCodeservice()
    {
        return $this->codeservice;
    }


    /**
     * Get type de situation : SISR :1, SLAM : 2
     *
     * @return integer
     */
    public function getTypeSituation()
    {
        return ($this->codeservice == null ? 2 : 1);
    }

    /**
     * Set refe4
     *
     * @param \AppBundle\Entity\Situatione4 $refe4
     *
     * @return Situation
     */
    public function setRefe4(\AppBundle\Entity\Situatione4 $refe4 = null)
    {
        $this->refe4 = $refe4;

        return $this;
    }

    /**
     * Get refe4
     *
     * @return \AppBundle\Entity\Situatione4
     */
    public function getRefe4()
    {
        return $this->refe4;
    }

    /**
     * Add idactivite
     *
     * @param \AppBundle\Entity\Activite $idactivite
     *
     * @return Situation
     */
    public function addIdactivite(\AppBundle\Entity\Activite $idactivite)
    {
        $this->idactivite[] = $idactivite;

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
     * Get idactivite
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getIdactivite()
    {
        return $this->idactivite;
    }

    /**
     * Get activite count
     *
     * @return integer
     */
    public function getActiviteCount()
    {
        return count($this->idactivite);
    }

    /**
     * Add code
     *
     * @param \AppBundle\Entity\Typologie $code
     *
     * @return Situation
     */
    public function addCode(\AppBundle\Entity\Typologie $code)
    {
        $this->code[] = $code;

        return $this;
    }

    /**
     * Remove code
     *
     * @param \AppBundle\Entity\Typologie $code
     */
    public function removeCode(\AppBundle\Entity\Typologie $code)
    {
        $this->code->removeElement($code);
    }

    /**
     *
     * Supprime tous les codes
     *
     */
    public function removeAllCodes()
    {
        $this->code->clear();
    }

    /**
     * Get code
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getCode()
    {
        return $this->code;
    }

    /**
     * Test if code is present
     *
     * @return bool
     */
    public function isCodePresent($code)
    {
        $exists =  $this->code->exists(function($key, $element) use ($code){
            return $element->getCode() == $code;
        }
        );
        return $exists;
    }


    /**
     *
     * Pour le tableau de synthèse
     *
     */
    private $arraySituationActiviteCites;
    public function setArraySituationActiviteCites($arraySituationActiviteCites)
    {
        $this->arraySituationActiviteCites = $arraySituationActiviteCites;
    }
    public function getArraySituationActiviteCites()
    {
        return $this->arraySituationActiviteCites;
    }
}
