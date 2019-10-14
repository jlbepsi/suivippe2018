<?php

namespace AppBundle\Controller;

use AppBundle\Controller\Prof\Utils\UtilisateursVerification;
use AppBundle\Manager\SituationManager;
use AppBundle\Manager\StageManager;
use AppBundle\Manager\UtilisateurManager;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Config\Definition\Exception\Exception;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     * @param Request $request
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function indexAction(Request $request)
    {
        return $this->render('default/index.html.twig');
    }

    /**
     * @Route("/detailprofil", name="profil")
     * @param Request $request
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function profilAction(Request $request)
    {
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();

        $serviceLdap = $this->get('security.user.provider.concrete.ldap_provider');
        // Obtention de l'utilisateur Ldap
        if (! $userLdap = $serviceLdap->loadUserLdapByLogin($user->getUsername()))
        {
            return $this->render("Exception/error404.html.twig");
        }

        $erreur = "";
        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            try
            {
                $userLdap->setNumexamen($request->get('utilisateur_numexam'));

                $serviceLdap->updateUserNumExam($userLdap->getLogin(), $userLdap->getNumexamen());
            }
            catch (Exception $exception)
            {

            }
        }

        return $this->render('default/profil.html.twig', array('utilisateur' => $userLdap, 'erreur' => $erreur));
    }


}
