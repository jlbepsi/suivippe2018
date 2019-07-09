<?php

namespace AppBundle\Controller;

use AppBundle\Manager\StageManager;
use Symfony\Component\Routing\Annotation\Route;
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
        // Obtention de l'utilisateur Ldap
        $serviceLdap = $this->get('security.user.provider.concrete.ldap_provider');
        if (! $userLdap = $serviceLdap->loadUserLdapByLogin($user->getUsername()))
        {
            return $this->render("Exception/error404.html.twig");
        }

        // Obtention de toutes les activités
        $competences = $this->getCompetenceManager()->loadAllCompetences();

        /* Liste des compétences
         * Chaque objet Activite contient la liste des situations (voir ActiviteCompetences.getReferenced)
         */
        $nbCompetences = count($competences);
        $cpt = 0;
        $activites = array();
        while ($cpt < $nbCompetences) {
            $activiteCompetence = new ActiviteCompetences($user->getUsername(), $competences[$cpt]->getIdactivite());

            while ($cpt < $nbCompetences && $activiteCompetence->getIdActivite() == $competences[$cpt]->getIdactivite()->getId()) {
                $activiteCompetence->addCompetence($competences[$cpt]);
                $cpt++;
            }
            $activites[$activiteCompetence->getActivite()->getId()] = $activiteCompetence;
        }

        // Ajout des activités provenant des situations
        $situations = $this->getSituationManager()->loadSituations($user->getUsername());
        foreach ($situations as $situation)
        {
            $situationActivites = $situation->getIdactivite();
            foreach ($situationActivites as $situationActivite)
            {
                $idActivite = $situationActivite->getId();
                if (array_key_exists($idActivite, $activites)) {
                    $activites[$idActivite]->addActiviteStage();
                } else {
                    $activiteCompetence = new ActiviteCompetences($user->getUsername(), $idActivite);
                    $activites[$idActivite] = $activiteCompetence;

                }
            }
        }

        // Ajout des activités provenant des stages
        $repositoryStageintituleactivite = $this->get('doctrine')->getRepository('AppBundle:Stageintituleactivite');
        // Obtention des activités du stage
        $stageintituleactivites = $repositoryStageintituleactivite->loadStageIntituleactiviteUser($user->getUsername());
        foreach ($stageintituleactivites as $stageintituleactivite)
        {
            $idActivite = $stageintituleactivite->getIdactivite()->getId();
            if (array_key_exists($idActivite, $activites)) {
                $activites[$idActivite]->addActiviteStage();
            } else {
                $activiteCompetence = new ActiviteCompetences($user->getUsername(), $idActivite);
                $activites[$idActivite] = $activiteCompetence;

            }
        }


        // Obtention du parcours
        $idParcours = $userLdap->getNumparcours();
        return $this->render('synthese/index.html.twig', array('activites' => $activites, 'idParcours' => $idParcours));
    }


    /**
     * @Route("/synthese/tableau", name="synthese_tableau")
     */
    public function tableauAction()
    {
        //return $this->render('synthese/tableau.html.twig', array('user' => $user, 'syntheseBuilder' => $syntheseBuilder));


        $user = $this->getUser();
        // Obtention de l'utilisateur Ldap
        $serviceLdap = $this->get('security.user.provider.concrete.ldap_provider');
        if (! $userLdap = $serviceLdap->loadUserLdapByLogin($user->getUsername()))
        {
            return $this->render("Exception/error404.html.twig");
        }

        return $this->generatePDF($userLdap);

    }

    private function generatePDF($user)
    {
        /*
         * LES DONNEES
         */
        // Obtention du parcours
        $idParcours = $user->getNumparcours();
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
        $situations = $this->getSituationManager()->loadSituations($user->getUsername());
        $syntheseBuilder->addSituations($situations);

        // Obtention des stages
        $stages = $this->getStageManager()->loadStageIntitulesUser($user->getUsername());
        $syntheseBuilder->addStagesIntitules($stages);


        /*
         * LA GENERATION DU PDF
         */
        $synthesePdf = new SynthesePdf($syntheseBuilder);

        return new Response($synthesePdf->generateSynthese(), 200, array('Content-Type' => 'application/pdf'));
    }
}
