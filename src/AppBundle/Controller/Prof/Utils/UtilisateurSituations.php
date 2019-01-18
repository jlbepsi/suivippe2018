<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 15/02/18
 * Time: 12:07
 */

namespace AppBundle\Controller\Prof\Utils;


use AppBundle\Entity\Situation;
use AppBundle\Entity\Utilisateur;

class UtilisateurSituations
{
    /**
     * @var Situation[]
     */
    private $situations = array();
    /**
     * @var \AppBundle\Entity\Utilisateur
     */
    private $utilisateur;
    /**
     * @var integer
     */
    private $analyseSituationActivite;

    /**
     * @return int
     */
    public function getAnalyseSituationActivite()
    {
        return $this->analyseSituationActivite;
    }

    /**
     * @param int $analyseSituationActivite
     */
    public function setAnalyseSituationActivite($analyseSituationActivite)
    {
        $this->analyseSituationActivite = $analyseSituationActivite;
    }

    /**
     * @return Utilisateur
     */
    public function getUtilisateur()
    {
        return $this->utilisateur;
    }

    /**
     * @param Utilisateur $utilisateur
     */
    public function setUtilisateur(Utilisateur $utilisateur)
    {
        $this->utilisateur = $utilisateur;
    }

    /**
     * @return \AppBundle\Entity\Situation[]
     */
    public function getSituations()
    {
        return $this->situations;
    }

    /**
     * @param $situations \AppBundle\Entity\Situation[]
     */
    public function setSituation($situations)
    {
        $this->situations = $situations;
    }

    /**
     * @param Situation $situation
     */
    public function addSituation(Situation $situation)
    {
        $this->situations[] = $situation;
    }

    public function verifierSituation()
    {
        $langages = array();
        $frameworks = array();
        $oss = array();
        $activites = array();

        $analyseSituationActivite = $this->analyseSituationActivite;

        $nbE4 = 0;
        // Obtention du parcours
        $numParcours = $this->getUtilisateur()->getNumparcours()->getId();

        $recommandations = null;
        if (count($this->situations) > 0) {
            $recommandations = array();
            foreach ($this->situations as $situation) {
                // Situation E4
                if ($situation->getRefe4())
                    $nbE4 += 1;
                // Nombre d'activité
                $activites[$situation->getReference()] = count($situation->getIdactivite());

                switch ($numParcours) {
                    case 2:     // SLAM
                        // Variété des frameworks et langages
                        if ($situation->getCodelangage()) {
                            $id = $situation->getCodelangage()->getId();
                            if (array_key_exists($id, $langages))
                                $langages[$id] += 1;
                            else
                                $langages[$id] = 1;

                        }
                        if ($situation->getCodeframework()) {

                            $id = $situation->getCodeframework()->getId();
                            if (array_key_exists($id, $frameworks))
                                $frameworks[$id] += 1;
                            else
                                $frameworks[$id] = 1;

                        }
                        break;

                    case 1:     // SISR
                        // Variété des OS et Services
                        // OS : Windows et Linux => 0, Linux => 1, Windows => 2
                        $id = $situation->getTypeos();
                        if ($id == 0) {
                            if (array_key_exists(1, $oss))
                                $oss[1] += 1;
                            else
                                $oss[1] = 1;
                            if (array_key_exists(2, $oss))
                                $oss[2] += 1;
                            else
                                $oss[2] = 1;
                        } else {
                            if (array_key_exists($id, $oss))
                                $oss[$id] += 1;
                            else
                                $oss[$id] = 1;
                        }
                        break;
                    default:
                        // Pas de recommendations
                        break;
                }
            }

            if ($this->getUtilisateur()->getClasse() == 'B1') {
                // Sinon aucune contrainte
                $nbE4 = 2;
            }

            // Situation E4
            if ($nbE4 < 2)
                $recommandations[] = "Vous devez avoir 2 situations E4";
            // Activités
            foreach ($activites as $activite) {
                if ($activite < $analyseSituationActivite) {
                    $recommandations[] = "Une situation doit avoir ". $analyseSituationActivite .   " activités minimum";
                    break;
                }
            }
            if ($numParcours == 2) {    // SLAM
                if (count($langages) < 2) {
                    $recommandations[] = "Vous devez avoir 2 langages différents";
                }
                if (count($frameworks) < 2) {
                    $recommandations[] = "Vous devez avoir 2 Framework différents";
                }
            }
            else if ($numParcours == 1) {    // SISR
                if (count($oss) < 2) {
                    $recommandations[] = "Vous devez avoir 2 OS différents";
                }
            }
        }

        return $recommandations;
    }

    public function countSituationsIncompletes()
    {
        $nbSituationsActivitesIncompletes = 0;

        $nbE4ToFind = 2;
        if (count($this->situations) > 0) {
            $nbE4 = 0;
            foreach ($this->situations as $situation) {
                // Situation E4
                if ($situation->getRefe4())
                    $nbE4ToFind--;
                // Nombre d'activité
                if (count($situation->getIdactivite()) < 5) {
                    $nbSituationsActivitesIncompletes++;
                }
            }

            // Situation E4
            if ($this->getUtilisateur()->getClasse() == 'B1') {
                // Pas de contrainte
                $nbE4ToFind = 0;
            }
        }

        if ($nbSituationsActivitesIncompletes < $nbE4ToFind)
            return $nbE4ToFind;
        // Trop de situation E4
        if ($nbSituationsActivitesIncompletes == 0 && $nbE4ToFind < 0)
            $nbSituationsActivitesIncompletes = 1;

        return $nbSituationsActivitesIncompletes;
    }
}