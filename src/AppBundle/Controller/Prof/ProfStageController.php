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

        // Obtention du service Ldap
        $serviceLdap = $this->get('security.user.provider.concrete.ldap_provider');
        $utilisateursStages = $this->getManager()->loadUtilisateursStages($serviceLdap, $classe);

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

        // Obtention de l'utilisateur Ldap
        $serviceLdap = $this->get('security.user.provider.concrete.ldap_provider');
        if (! $userLdap = $serviceLdap->loadUserLdapByLogin($userLogin))
        {
            return $this->render("Exception/error404.html.twig");
        }

        // Recherche du film
        if (!$stage = $manager->loadSingleStage($id))
        {
            return $this->render("Exception/error404.html.twig");
        }

        $typologies = $manager->loadTypologies();
        // Obtention des activités
        $intitulesActivites = $manager->loadStageIntitules($id);

        $utilisateurStages = new UtilisateurStages();
        foreach ($intitulesActivites as $stagesIntitule) {
            $stage->addIntitulesActivites($stagesIntitule);
        }
        $utilisateurStages->addStage($stage);
        $recommandations = $utilisateurStages->verifierStage();

        return $this->render('prof/stage/edit.html.twig', array(
            'stage' => $stage,
            'etudiant' => $userLdap,
            'recommandations' => $recommandations,
            'intitulesActivites' => $intitulesActivites,
            'typologies' => $typologies));
    }

    /**
     * @Route("/prof/stage/analyse", name="prof_stage_analyse")
     */
    public function analyseStageAction()
    {
        $serviceLdap = $this->get('security.user.provider.concrete.ldap_provider');
        // Obtention du manager puis des stages
        $utilisateursStages = $this->getManager()->loadUtilisateursStages($serviceLdap);

        $analyse = $utilisateursStages->analyseUtilisateursStages();

        return new JsonResponse(array('nbUtilisateurs' => $analyse['nbUtilisateurs'], 'nbStages' => $analyse['nbStages'],
            'nbUtilisateursSansStage' => $analyse['nbUtilisateursSansStage'],
            'nbStagesIncomplets' => $analyse['nbStagesIncomplets']));
    }
}
