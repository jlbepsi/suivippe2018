<?php

namespace AppBundle\Controller\Teacher;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class ProfStageController extends Controller
{
    /**
     * @Route("/admin/stage", name="prof_stage_index")
     */
    public function indexAction()
    {
        return $this->render('admin/stage/index.html.twig', array());
    }
}
