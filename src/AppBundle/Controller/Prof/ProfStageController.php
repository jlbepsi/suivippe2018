<?php

namespace AppBundle\Controller\Prof;

use AppBundle\Controller\Prof\Utils\UtilisateurStages;
use Symfony\Component\Routing\Annotation\Route;
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
    public function indexAction(Request $request)
    {
        $classe = null;
        if ($request->getMethod() == 'POST') {

            // Récupération des infos
            $classe = $request->request->get('classeSearch');
            if ($classe == 'Toutes')
                $classe = null;
        }

        // Obtention des situations
        $utilisateursStages = $this->getManager()->loadUtilisateursStages($classe);

        return $this->render('prof/stage/index.html.twig',
            array('utilisateursStages' => $utilisateursStages, 'classe' => $classe));
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
            return $this->render("Exception/error404.html.twig");
        }

        $typologies = $manager->loadTypologies();
        // Obtention des activités
        $intitulesActivites = $manager->loadStageIntitules($id);

        $utilisateurStages = new UtilisateurStages();
        $utilisateurStages->addStage($stage);
        $recommandations = $utilisateurStages->verifierStage();

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

        return new JsonResponse(array('nbUtilisateurs' => $analyse['nbUtilisateurs'], 'nbStages' => $analyse['nbStages'],
            'nbUtilisateursSansStage' => $analyse['nbUtilisateursSansStage'],
            'nbStagesIncomplets' => $analyse['nbStagesIncomplets']));
    }
}
