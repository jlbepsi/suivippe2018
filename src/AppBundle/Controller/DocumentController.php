<?php

namespace AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Routing\Annotation\Route;

class DocumentController extends Controller
{
    /**
     * @Route("/documents", name="document_index")
     */
    public function indexAction()
    {
        return $this->render('document/index.html.twig');
    }

    /**
     * @Route("/documents/E4", name="document_E4")
     */
    public function e4Action()
    {
        return $this->render('document/e4.html.twig');
    }

    /**
     * @Route("/documents/E6", name="document_E6")
     */
    public function e6Action()
    {
        return $this->render('document/e6.html.twig');
    }
}
