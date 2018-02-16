<?php

namespace AppBundle\Controller\Teacher;

use AppBundle\Controller\Teacher\Utils\UtilisateursSituations;
use AppBundle\Manager\SituationManager;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class ProfSituationController extends Controller
{
    private function getManager()
    {
        return new SituationManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/admin/situation", name="prof_situation_index")
     */
    public function indexAction()
    {
        // Obtention des situations
        $situations = $this->getManager()->loadAllSituations();

        $utilisateursSituations = new UtilisateursSituations();
        $utilisateursSituations->setSituations($situations);

        return $this->render('admin/situation/index.html.twig', array('utilisateursSituations' => $utilisateursSituations));
    }
}
