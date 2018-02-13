<?php

namespace AppBundle\Controller;

use AppBundle\Entity\Situatione4;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

use AppBundle\Entity\Situation;
use AppBundle\Manager\SituationManager;
use AppBundle\Form\SituationType;
use AppBundle\Form\SituationSearchCriteria;
use AppBundle\Form\SituationSearchType;


class SituationController extends Controller
{
    private function getManager()
    {
        return new SituationManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/situation", name="situation_index")
     */
    public function indexAction(Request $request)
    {
        $situationSearch = new SituationSearchCriteria();
        $form = $this->createForm(SituationSearchType::class, $situationSearch);

        // Obtention de l'utilisateur connecté
        $user = $this->getUser();

        if ($request->getMethod() == 'POST') {
            $form->handleRequest($request);

            // L'utilisateur utilise le formulaire recherche
            $situations = $this->getManager()->loadSituationsWhere($form->getData(), $user->getLogin());
        }
        else {
            // Obtention des situations
            $situations = $this->getManager()->loadSituations($user->getLogin());
        }
        // Obtention du parcours
        $idParcours = $user->getNumparcours()->getId();

        return $this->render('situation/index.html.twig', array('arraySituations' => $situations, 'count' => count($situations),
            'form' => $form->createView(), 'idParcours' => $idParcours, 'classe' => $user->getClasse()));
    }

    /**
     * @Route("/situation/count", name="situation_count")
     */
    public function countAction()
    {
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        // Obtention du manager puis des films
        $count = $this->getManager()->countSituations($user->getLogin());

        return new JsonResponse(array('count' => $count));
    }

    /**
     * @Route("/situation/add", name="situation_add")
     */
    public function addAction(Request $request)
    {
        // Création d'une nouvelle situation
        $situation = new Situation();

        // Création du modèle du formulaire
        $model = $this->get('form.factory')->create(SituationType::class, $situation);
        // Obtention du manager
        $manager = $this->getManager();

        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // Attachement du modèle à l'objet "request"
            $model->handleRequest($request);
            // Validation du modèle
            if ($model->isValid())
            {
                // Fixe le login
                $situation->setLogin($user);

                // Obtention du parcours
                $radioParcours = $request->request->get('radioParcours');
                if ($radioParcours != null)
                {
                    if ($radioParcours == 1) // SISR
                    {
                        $situation->setCodeframework(null);
                        $situation->setCodelangage(null);
                    }
                    else // SLAM
                    {
                        $situation->setCodeos(null);
                        $situation->setCodeservice(null);
                    }

                }

                // Obtention des situations obligatoires: Typologie
                $mandatory = $request->request->get('mandatory');
                $manager->saveTypologies($situation, $mandatory);
                // Validation de l'entité
                $manager->saveSituation($situation);

                return $this->redirectToRoute('situation_index');
            }
        }

        $typologies = $manager->loadTypologies();
        // Obtention du parcours
        $idParcours = $user->getNumparcours()->getId();

        return $this->render('situation/add.html.twig', array('form' => $model->createView(),
                                'situation' => $situation, 'typologies' => $typologies,
                                'idParcours' => $idParcours));
    }

    /**
     * @Route("/situation/edit/{id}", name="situation_edit")
     */
    public function editAction(Request $request, $id)
    {
        // Obtention du manager
        $manager = $this->getManager();
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        // Recherche du film
        if (!$situation = $manager->loadSituation($id, $user->getLogin()))
        {
            return $this->render("TwigBundle/views/Exception/error404.html.twig");
        }

        // Création du modèle du formulaire
        $model = $this->get('form.factory')->create(SituationType::class, $situation);

        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // Attachement du modèle à l'objet "request"
            $model->handleRequest($request);
            // Validation du modèle
            if ($model->isValid())
            {
                // Obtention des situations obligatoires: Typologie
                $mandatory = $request->request->get('mandatory');
                $manager->saveTypologies($situation, $mandatory);

                // Situation E4 ?
                $situationE4Active = $request->request->get('situationE4');
                if ($situationE4Active == "on")
                {
                    $optionsE4 = $request->request->get('optionsE4');
                    $sgdbE4 = $request->request->get('e4_sgdb');
                    $equipeE4 = $request->request->get('e4_equipe');
                    $contexteE4 = $request->request->get('e4_contexte');
                    $realisationE4 = $request->request->get('e4_realisation');

                    $situationE4 = new Situatione4();
                    $situationE4->setReferencee4($situation->getReference());
                    $situationE4->setCompetenceapplication($optionsE4);
                    $situationE4->setCompetencesgbd($sgdbE4=="on" ? 1 : 0);
                    $situationE4->setEquipe($equipeE4);
                    $situationE4->setContexte($contexteE4);
                    $situationE4->setRealisation($realisationE4);
                    $situationE4->setIntitule($situation->getLibelle());

                    // Validation de l'entité
                    $manager->saveSituationE4($situationE4);

                    $situation->setRefe4($situationE4);
                }
                else
                {
                    // La situation E4 doit être supprimée si elle existe
                    $manager->removeSituationE4($situation->getRefe4());
                }
                // Validation de la situation
                $manager->saveSituation($situation);
            }
        }

        // Obtention des activités
        $activites = $manager->loadSituationActivites();
        // Typologies
        $typologies = $manager->loadTypologies();
        // Obtention du parcours
        $idParcours = $user->getNumparcours()->getId();

        return $this->render('situation/edit.html.twig', array('form' => $model->createView(),
                                'situation' => $situation, 'typologies' => $typologies,
                                'activites' => $activites,'idParcours' => $idParcours));
    }

    /**
     * @Route("/situation/delete", name="situation_delete")
     */
    public function deleteAction(Request $request) {
        // Si l'utilisateur appelle bien la suppresion en AJAX - POST
        // Récupération des infos
        $refSituation = $request->request->get('refSituation');

        if ($request->getMethod() == 'POST') {
            // Obtention du manager
            $manager = $this->getManager();
            // Obtention de l'utilisateur connecté
            $user = $this->getUser();
            // Recherche de la situation
            if ($situation = $manager->loadSituation($refSituation, $user->getLogin())) {
                $message = "La situation a été supprimé";
                $status = 1;
                // Suppression du film
                try {
                    // La situation E4 doit être supprimée si elle existe
                    $manager->removeSituationE4($situation->getRefe4());
                    $manager->removeSituation($situation);
                } catch (\Exception $e) {
                    $message = sprintf("Vous ne pouvez pas supprimer la situation: %s",
                        $e->getMessage());
                    $status = -1;
                }
            } else {
                $message = "La situation n'existe pas";
                $status = -1;
            }
        } else {
            $message = "L'appel de la méthode de suppression est incorrecte";
            $status = $id = -1;
        }

        // Retour du résultat en Json
        return new JsonResponse(array('status' => $status, 'message' => $message, 'id' => $refSituation));
    }

    /**
     * @Route("/situation/addactivite", name="situation_addactivite")
     */
    public function addActiviteAction(Request $request)
    {
        $id = 0;
        $status = -1;

        // Obtention de l'objet "request"
        //$request = $this->get('request');
        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // Récupération de l'ID du stage à supprimer
            $idActivite = $request->request->get('id');
            $reference = $request->request->get('reference');

            // Obtention du manager
            $manager = $this->getManager();
            // Obtention de l'utilisateur connecté
            $user = $this->getUser();
            // Recherche de la situation
            if ($situation = $manager->loadSituation($reference, $user->getLogin())) {
                $status = 1;
                // Ajout de l'activité
                try
                {
                    $manager->addSituationActivite($situation, $idActivite);
                    $id = $idActivite;
                }
                catch (\Exception $e)
                {
                    $status = -1;
                }
            }

        }

        // Retour du résultat en Json
        return new JsonResponse(array('status' => $status, 'id' => $id));
    }

    /**
     * @Route("/situation/removeactivite", name="situation_removeactivite")
     */
    public function removeActiviteAction(Request $request)
    {
        $id = 0;
        $status = -1;

        // Obtention de l'objet "request"
        //$request = $this->get('request');
        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // Récupération de l'ID du stage à supprimer
            $idActivite = $request->request->get('id');
            $reference = $request->request->get('reference');

            // Obtention du manager
            $manager = $this->getManager();
            // Obtention de l'utilisateur connecté
            $user = $this->getUser();
            // Recherche de la situation
            if ($situation = $manager->loadSituation($reference, $user->getLogin())) {
                $status = 1;
                // Ajout de l'activité
                try
                {
                    $manager->removeSituationActivite($situation, $idActivite);
                    $id = $idActivite;
                }
                catch (\Exception $e)
                {
                    $status = -1;
                }
            }

        }

        // Retour du résultat en Json
        return new JsonResponse(array('status' => $status, 'id' => $id));
    }
}
