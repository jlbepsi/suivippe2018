<?php

namespace AppBundle\Controller\Prof;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Routing\Annotation\Route;

class ProfesseurDefaultController extends Controller
{

    /**
     * @Route("/prof", name="prof_homepage")
     */
    public function indexAction()
    {
        return $this->render('prof/default/index.html.twig', array('name' => 'prof'));
    }
}
