<?php

namespace AppBundle\Controller;

use AppBundle\Entity\Utilisateur;
use AppBundle\Manager\UtilisateursAPIManager;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/api")
 */
class UtilisateursWSController extends Controller
{
    private function getManager()
    {
        return new UtilisateursAPIManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/utilisateurs", methods={"GET"})
     */
    public function getUsersAction(Request $request)
    {
        $utilisateurs = $this->getManager()->loadAllUtilisateurs();
        // Retour du résultat en Json
        return new JsonResponse(array('utilisateurs' => $utilisateurs));
    }

    /**
     * @Route("/utilisateurs/{login}", methods={"GET"})
     */
    public function getUserAction(Request $request, $login)
    {
        $utilisateur = $this->getManager()->loadUtilisateurs($login);
        // Retour du résultat en Json
        return new JsonResponse(array('utilisateur' => $utilisateur));
    }

    /**
     * @Route("/utilisateurs/", methods={"POST"})
     */
    public function addUserAction(Request $request, Utilisateur $utilisateur)
    {
        // TODO : Faire API REST PUT
        // Retour du résultat en Json
        return new JsonResponse(array('utilisateur' => null));
    }

    /**
     * @Route("/utilisateurs/{login}", methods={"PUT"})
     */
    public function updateUserAction(Request $request, $login)
    {
        // TODO : Faire API REST PUT
        // Retour du résultat en Json
        return new JsonResponse(array('utilisateur' => null));
    }
}
