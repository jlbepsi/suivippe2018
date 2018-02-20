<?php

namespace AppBundle\Controller\Prof;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;

use AppBundle\Controller\Prof\Utils\UtilisateursSituations;
use AppBundle\Manager\SituationManager;


class ProfSituationController extends Controller
{
    private function getManager()
    {
        return new SituationManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/prof/situation", name="prof_situation_index")
     */
    public function indexAction()
    {
        // Obtention des situations
        $utilisateursSituations = $this->getManager()->loadUtilisateursSituations();

        return $this->render('prof/situation/index.html.twig', array('utilisateursSituations' => $utilisateursSituations));
    }

    /**
     * @Route("/prof/situation/edit/{id}", name="prof_situation_edit")
     */
    public function editAction(Request $request, $id)
    {
        // Obtention du manager
        $manager = $this->getManager();
        // Obtention de l'utilisateur de la situaion
        $userLogin = $request->get('user');
        // Recherche de la situation
        if (!$situation = $manager->loadSingleSituation($id))
        {
            return $this->render("TwigBundle/views/Exception/error404.html.twig");
        }

        // Commentaires
        $commentaires = $manager->loadCommentaires($id);
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();

        return $this->render('prof/situation/edit.html.twig', array('situation' => $situation,
            'idParcours' => $situation->getLogin()->getNumparcours()->getId(),
            'commentaires' => $commentaires, 'loginProf' => $user->getUsername()));
    }



    /**
     * @Route("/prof/situation/count", name="prof_situation_count")
     */
    public function countSituationAction()
    {
        // Obtention du manager puis des films
        $count = $this->getManager()->countAllSituations();

        return new JsonResponse(array('count' => $count));
    }

    /*
     *
     * COMMENTAIRES
     *
     */

    /**
     * @Route("/prof/situation/countcomment", name="prof_commentaire_count")
     */
    public function countCommentaireAction()
    {
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        // Obtention du manager puis des films
        $count = $this->getManager()->countCommentaires($user->getLogin());

        return new JsonResponse(array('count' => $count));
    }

    /**
     * @Route("/prof/situation/addcommentaire", name="situation_commentaire_add")
     */
    public function addCommentaireAction(Request $request) {

        $id = -1;
        $prof = "";
        $today = new \DateTime('now');
        $dateCommentaire = $today->format('d/m/Y');

        // Si l'utilisateur appelle bien l'ajout en AJAX - POST
        if ($request->getMethod() == 'POST') {

            // Obtention du manager
            $manager = $this->getManager();

            // Récupération des infos
            $refSituation = $request->request->get('refSituation');
            $commentaire = $request->request->get('commentaire');

            // Recherche de la situation
            if ($situation = $manager->loadSingleSituation($refSituation))
            {
                $message = "Le commentaire a été ajouté";
                $status = 1;

                // Obtention de l'utilisateur connecté
                $user = $this->getUser();
                $prof = $user->getlogin();
                // Création de l'intitulé
                try {
                    $id = $manager->addSituationCommentaire($situation, $commentaire, $user, $today);
                    if ($id == 0) {
                        $message = "Impossible d'ajouter le commentaire";
                        $status = -1;
                    }
                } catch (\Exception $e) {
                    $message = sprintf("L'erreur suivante est survenue lors de l'ajout du commentaire: %s",
                        $e->getMessage());
                    $status = -1;
                }
            } else {
                $message = "Le commentaire n'existe pas";
                $status = -1;
            }
        }
        else
        {
            $message = "L'appel de la méthode d'ajout est incorrecte";
            $status = $id = -1;
        }

        // Retour du résultat en Json
        return new JsonResponse(array('status' => $status, 'message' => $message,
            'id' => $id, 'date' => $dateCommentaire, 'commentaire' => $commentaire, 'prof' => $prof));
    }

    /**
     * @Route("/prof/situation/modifycommentaire", name="situation_commentaire_modify")
     */
    public function modifyCommentaireAction(Request $request)
    {
        // Récupération des infos
        $id = $request->request->get('id');
        $textCommentaire = $request->request->get('commentaire');
        $today = new \DateTime('now');
        $dateCommentaire = $today->format('d/m/Y');
        $status = -1;

        // Si l'utilisateur appelle bien la modification en AJAX - POST
        if ($request->getMethod() == 'POST') {

            // Obtention du manager
            $manager = $this->getManager();
            // Recherche du commentaire
            if ($commentaire = $manager->loadCommentaire($id)) {
                $message = "Le commentaire aétémodifié";
                $status = 1;
                // Modification du commentaire
                $commentaire->setCommentaire($textCommentaire);
                $commentaire->setDatecommentaire(new \DateTime('now'));
                try {
                    $manager->saveCommentaire($commentaire);
                } catch (\Exception $e) {
                    $message = sprintf("L'erreur suivante est survenue lors de la modification du commentaire: %s",
                        $e->getMessage());
                    $status = -1;
                }
            } else {
                $message = "Le commentaire n'existe pas";
                $status = -1;
            }
        }
        else
        {
            $message = "L'appel de la méthode de suppression est incorrecte";
            $status = $id = -1;
        }

        // Retour du résultat en Json
        return new JsonResponse(array('status' => $status, 'message' => $message,
                                      'id' => $id, 'commentaire' => $textCommentaire, 'date' => $dateCommentaire));
    }

    /**
     * @Route("/prof/situation/deletecommentaire", name="situation_commentaire_delete")
     */
    public function deleteCommentaireAction(Request $request) {
        // Récupération des infos
        $id = $request->request->get('id');

        $status = -1;
        // Si l'utilisateur appelle bien la suppresion en AJAX - POST
        if ($request->getMethod() == 'POST') {

            // Obtention du manager
            $manager = $this->getManager();
            // Recherche du commentaire
            if ($commentaire = $manager->loadCommentaire($id)) {
                $message = "Le commentaire aétésupprimé";
                $status = 1;
                // Suppression du commentaire
                try {
                    $manager->removeCommentaire($commentaire);
                } catch (\Exception $e) {
                    $message = sprintf("L'erreur suivante est survenue lors de la suppression du commentaire: %s",
                        $e->getMessage());
                    $status = -1;
                }
            } else {
                $message = "Le commentaire n'existe pas";
                $status = -1;
            }
        }
        else
        {
            $message = "L'appel de la méthode de suppression est incorrecte";
            $status = $id = -1;
        }

        // Retour du résultat en Json
        return new JsonResponse(array('status' => $status, 'message' => $message, 'id' => $id));
    }
}
