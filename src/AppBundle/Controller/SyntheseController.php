<?php

namespace AppBundle\Controller;

use AppBundle\Manager\StageManager;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

use AppBundle\Manager\CompetenceManager;
use AppBundle\Manager\ActiviteCompetences;
use AppBundle\Manager\SyntheseManager;
use AppBundle\Manager\SituationManager;
use AppBundle\Manager\SyntheseBuilder;
use AppBundle\Manager\SynthesePDF;


class SyntheseController extends Controller
{
    private function getCompetenceManager()
    {
        return new CompetenceManager($this->get('doctrine')->getManager());
    }
    private function getSyntheseManager()
    {
        return new SyntheseManager($this->get('doctrine')->getManager());
    }
    private function getSituationManager()
    {
        return new SituationManager($this->get('doctrine')->getManager());
    }
    private function getStageManager()
    {
        return new StageManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/synthese", name="synthese_index")
     */
    public function indexAction()
    {
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        // Obtention de toutes les activités
        $competences = $this->getCompetenceManager()->loadAllCompetences();

        $nbCompetences = count($competences);
        $cpt = 0;
        $activites = array();
        while ($cpt < $nbCompetences) {
            $activiteCompetence = new ActiviteCompetences($user->getLogin(), $competences[$cpt]->getIdactivite());

            while ($cpt < $nbCompetences && $activiteCompetence->getIdActivite() == $competences[$cpt]->getIdactivite()->getId()) {
                $activiteCompetence->addCompetence($competences[$cpt]);
                $cpt++;
            }
            $activites[] = $activiteCompetence;
        }

        // Obtention du parcours
        $idParcours = $user->getNumparcours()->getId();
        return $this->render('synthese/index.html.twig', array('activites' => $activites, 'idParcours' => $idParcours));
    }


    /**
     * @Route("/synthese/tableau", name="synthese_tableau")
     */
    public function tableauAction()
    {
        //return $this->render('synthese/tableau.html.twig', array('user' => $user, 'syntheseBuilder' => $syntheseBuilder));

        return $this->generatePDF($this->getUser());

    }

    private function generatePDF($user)
    {
        /*
         * LES DONNEES
         */
        // Obtention du parcours
        $idParcours = $user->getNumparcours()->getId();
        // Obtention de toutes les activités
        $activitesDomaine = $this->getSyntheseManager()->loadActivitesDomaine($idParcours);

        // L'objet qui conteindra toutes les informations pré-formatées
        $syntheseBuilder = new SyntheseBuilder();
        // L'utilisateur
        $syntheseBuilder->setUtilisateur($user);
        // Obtention des activités et domaines
        $syntheseBuilder->addActivitesDomaine($activitesDomaine);
        // Obtention des typologies
        $typologies = $this->getSyntheseManager()->loadTypologies();
        $syntheseBuilder->addTypologies($typologies);
        // Obtention des situations
        $situations = $this->getSituationManager()->loadSituations($user->getLogin());
        $syntheseBuilder->addSituations($situations);

        // Obtention des stages
        $stages = $this->getStageManager()->loadStageIntitulesActivitesUser($user->getLogin());
        $syntheseBuilder->addStagesIntitules($stages);


        /*
         * LA GENERATION DU PDF
         */
        $synthesePdf = new SynthesePdf($syntheseBuilder);

        return new Response($synthesePdf->generateSynthese(), 200, array('Content-Type' => 'application/pdf'));
    }
}
