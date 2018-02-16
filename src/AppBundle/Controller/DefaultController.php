<?php

namespace AppBundle\Controller;

use AppBundle\Form\UtilisateurType;
use AppBundle\Manager\UtilisateurManager;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Config\Definition\Exception\Exception;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends Controller
{
    private function getManager()
    {
        return new UtilisateurManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/", name="homepage")
     */
    public function indexAction(Request $request)
    {
        return $this->render('default/index.html.twig');
    }

    /**
     * @Route("/profil", name="profil")
     */
    public function profilAction(Request $request)
    {
        $manager = $this->getManager();
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        // Recherche du film
        if (!$utilisateur = $manager->loadUser($user->getLogin()))
        {
            return $this->render("TwigBundle/views/Exception/error404.html.twig");
        }

        $erreur = "";
        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // L'utilsateur ne peut changer que 3 champs: sexe, datenaissance et adresse
            try
            {
                $utilisateur->setSexe($request->get('utilisateur_sexe'));
                $dateNaissance = \DateTime::createFromFormat('d/m/Y', $request->get('utilisateur_datenaissance'));
                $utilisateur->setDateNaissance($dateNaissance);
                $utilisateur->setAdresse($request->get('utilisateur_adresse'));
                $utilisateur->setNumexamen($request->get('utilisateur_numexam'));

                // Validation de l'entité
                $manager->saveUser($utilisateur);
            }
            catch (\Exception $exception)
            {

            }
        }

        return $this->render('default/profil.html.twig', array('utilisateur' => $utilisateur, 'erreur' => $erreur));
    }
}
