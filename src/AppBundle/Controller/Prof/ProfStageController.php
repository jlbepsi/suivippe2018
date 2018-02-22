<?php

namespace AppBundle\Controller\Prof;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

use AppBundle\Manager\StageManager;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

class ProfStageController extends Controller
{
    private function getManager()
    {
        return new StageManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/prof/stage", name="prof_stage_index")
     */
    public function indexAction()
    {
        // Obtention des situations
        $utilisateursStages = $this->getManager()->loadUtilisateursStages();

        return $this->render('prof/stage/index.html.twig', array('utilisateursStages' => $utilisateursStages));
    }

    /**
     * @Route("/prof/stage/edit/{id}", name="prof_stage_edit")
     */
    public function editAction(Request $request, $id)
    {
        // Obtention du manager
        $manager = $this->getManager();
        // Obtention de l'utilisateur
        $userLogin = $request->get('user');
        // Recherche du film
        if (!$stage = $manager->loadSingleStage($id))
        {
            return $this->render("TwigBundle/views/Exception/error404.html.twig");
        }

        $typologies = $manager->loadTypologies();
        // Obtention des activités
        $intitulesActivites = $manager->loadStageIntitules($id);


        $recommandations = null;
        $nbStagesActivitesIncomplets = $stage->analyseActivites();
        if ($nbStagesActivitesIncomplets > 0) {
            $recommandations[] = "Un stage doit avoir au moins 4 activités pour chaque intitulé";
        }

        return $this->render('prof/stage/edit.html.twig', array('stage' => $stage, 'recommandations' => $recommandations,
                    'intitulesActivites' => $intitulesActivites, 'typologies' => $typologies));
    }

    /**
     * @Route("/prof/stage/analyse", name="prof_stage_analyse")
     */
    public function analyseStageAction()
    {
        // Obtention du manager puis des stages
        $utilisateursStages = $this->getManager()->loadUtilisateursStages();

        $analyse = $utilisateursStages->analyseUtilisateursStages();

        return new JsonResponse(array('nbStages' => $analyse['nbStages'],
            'nbUtilisateursSansStage' => $analyse['nbUtilisateursSansStage'],
            'nbStagesIncomplets' => $analyse['nbStagesIncomplets']));
    }
}
