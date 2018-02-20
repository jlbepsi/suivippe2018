<?php

namespace AppBundle\Controller\Prof;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

use AppBundle\Manager\StageManager;
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

        return $this->render('prof/stage/edit.html.twig', array('stage' => $stage));
    }
}
