<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Stage
 *
 * @ORM\Table(name="stage", indexes={@ORM\Index(name="login", columns={"login"})})
 * @ORM\Entity(repositoryClass="AppBundle\Entity\StageRepository")
 */
class Stage
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
     * @var integer
     *
     * @ORM\Column(name="annee", type="integer", nullable=false)
     */
    private $annee;

    /**
     * @var string
     *
     * @ORM\Column(name="libelleCourt", type="string", length=100, nullable=false)
     */
    private $libellecourt;

    /**
     * @var string
     *
     * @ORM\Column(name="descriptif", type="string", length=250, nullable=true)
     */
    private $descriptif;

    /**
     * @var string
     *
     * @ORM\Column(name="entrepriseNom", type="string", length=100, nullable=true)
     */
    private $entreprisenom;

    /**
     * @var string
     *
     * @ORM\Column(name="entrepriseAdresse", type="string", length=250, nullable=true)
     */
    private $entrepriseadresse;

    /**
     * @var string
     *
     * @ORM\Column(name="entrepriseContact", type="string", length=200, nullable=true)
     */
    private $entreprisecontact;

    /**
     * @var string
     *
     * @ORM\Column(name="entrepriseLogo", type="string", length=100, nullable=true)
     */
    private $entrepriselogo;

    /**
     * @var float
     *
     * @ORM\Column(name="montant", type="float", precision=10, scale=0, nullable=false)
     */
    private $montant;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="dateDebut", type="date", nullable=false)
     */
    private $datedebut;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="dateFin", type="date", nullable=false)
     */
    private $datefin;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="dateModif", type="datetime", nullable=false)
     */
    private $datemodif;

    /**
     * @var \AppBundle\Entity\Utilisateur
     *
     * @ORM\ManyToOne(targetEntity="Utilisateur")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="login", referencedColumnName="login")
     * })
     */
    private $login;

    /**
     * @var \Doctrine\Common\Collections\Collection
     *
     * @ORM\ManyToMany(targetEntity="Typologie", inversedBy="idstage")
     * @ORM\JoinTable(name="stagetypo",
     *   joinColumns={
     *     @ORM\JoinColumn(name="idstage", referencedColumnName="id")
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
        $this->code = new \Doctrine\Common\Collections\ArrayCollection();
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
     * Set annee
     *
     * @param integer $annee
     *
     * @return Stage
     */
    public function setAnnee($annee)
    {
        $this->annee = $annee;

        return $this;
    }

    /**
     * Get annee
     *
     * @return integer
     */
    public function getAnnee()
    {
        return $this->annee;
    }

    /**
     * Set libellecourt
     *
     * @param string $libellecourt
     *
     * @return Stage
     */
    public function setLibellecourt($libellecourt)
    {
        $this->libellecourt = $libellecourt;

        return $this;
    }

    /**
     * Get libellecourt
     *
     * @return string
     */
    public function getLibellecourt()
    {
        return $this->libellecourt;
    }

    /**
     * Set descriptif
     *
     * @param string $descriptif
     *
     * @return Stage
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
     * Set entreprisenom
     *
     * @param string $entreprisenom
     *
     * @return Stage
     */
    public function setEntreprisenom($entreprisenom)
    {
        $this->entreprisenom = $entreprisenom;

        return $this;
    }

    /**
     * Get entreprisenom
     *
     * @return string
     */
    public function getEntreprisenom()
    {
        return $this->entreprisenom;
    }

    /**
     * Set entrepriseadresse
     *
     * @param string $entrepriseadresse     *
     * @return Stage
     */
    public function setEntrepriseadresse($entrepriseadresse)
    {
        $this->entrepriseadresse = $entrepriseadresse;

        return $this;
    }

    /**
     * Get entrepriseadresse
     *
     * @return string
     */
    public function getEntrepriseadresse()
    {
        return $this->entrepriseadresse;
    }

    /**
     * Set entreprisecontact
     *
     * @param string $entreprisecontact     *
     * @return Stage
     */
    public function setEntreprisecontact($entreprisecontact)
    {
        $this->entreprisecontact = $entreprisecontact;

        return $this;
    }

    /**
     * Get entreprisecontact
     *
     * @return string
     */
    public function getEntreprisecontact()
    {
        return $this->entreprisecontact;
    }

    /**
     * Set entrepriselogo
     *
     * @param string $entrepriselogo     *
     * @return Stage
     */
    public function setEntrepriselogo($entrepriselogo)
    {
        $this->entrepriselogo = $entrepriselogo;

        return $this;
    }

    /**
     * Get entrepriselogo
     *
     * @return string
     */
    public function getEntrepriselogo()
    {
        return $this->entrepriselogo;
    }

    /**
     * Set montant
     *
     * @param float $montant     *
     * @return Stage
     */
    public function setMontant($montant)
    {
        $this->montant = $montant;

        return $this;
    }

    /**
     * Get montant
     *
     * @return float
     */
    public function getMontant()
    {
        return $this->montant;
    }

    /**
     * Set datedebut
     *
     * @param \DateTime $datedebut     *
     * @return Stage
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
     * @param \DateTime $datefin     *
     * @return Stage
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
     * Get duree
     *
     * @return integer
     */
    public function getDuree()
    {
        $interval = $this->datedebut->diff($this->datefin);
        return ceil($interval->days/7);
    }

    /**
     * Set datemodif
     *
     * @param \DateTime $datemodif     *
     * @return Stage
     */
    public function setDatemodif($datemodif)
    {
        $this->datemodif = $datemodif;

        return $this;
    }

    /**
     * Get datemodif
     *
     * @return \DateTime
     */
    public function getDatemodif()
    {
        return $this->datemodif;
    }

    /**
     * Set login
     *
     * @param \AppBundle\Entity\Utilisateur $login     *
     * @return Stage
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
     * Add code
     *
     * @param \AppBundle\Entity\Typologie $code     *
     * @return Stage
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
    private $arrayStageActiviteCites;
    public function setArrayStageActiviteCites($arrayStageActiviteCites)
    {
        $this->arrayStageActiviteCites = $arrayStageActiviteCites;
    }
    public function getArrayStageActiviteCites()
    {
        return $this->arrayStageActiviteCites;
    }

    /**
     *
     * Pour l'analyse des stages par le prof (voir UtilisateurStages)
     *
     */
    /**
     * @var array
     */
    private $arrayIntitulesActivites = null;

    /**
     * @return array
     */
    public function getArrayIntitulesActivites()
    {
        return $this->arrayIntitulesActivites;
    }

    /**
     * @param $stagesIntitule \AppBundle\Entity\Stageintitule
     */
    public function addIntitulesActivites($stagesIntitule)
    {
        $info = array('idIntitule' => $stagesIntitule->getIdintitule(), 'nbActivite' => count($stagesIntitule->getIdactivite()));
        $this->arrayIntitulesActivites[] = $info;
    }

    public function analyseActivites()
    {
        $nbStagesActivitesIncomplets = 0;
        if ($this->arrayIntitulesActivites == null)
        {
            $nbStagesActivitesIncomplets++;
        }
        else
        {
            $nbIntitules = count($this->arrayIntitulesActivites);
            if ($nbIntitules < 3)
                $nbStagesActivitesIncomplets++;
            else {
                foreach ($this->arrayIntitulesActivites as $intitulesActivite) {
                    if ($intitulesActivite["nbActivite"] < 4) {
                        $nbStagesActivitesIncomplets++;
                        break;
                    }
                }
            }
        }

        return $nbStagesActivitesIncomplets;
    }
}
