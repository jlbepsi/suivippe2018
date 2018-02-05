<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

use AppBundle\Entity\Stageintitule;
use AppBundle\Manager\ActiviteManager;
use AppBundle\Entity\Stage;
use AppBundle\Manager\StageManager;
use AppBundle\Form\StageType;

class StageController extends Controller
{
    private function getManager()
    {
        return new StageManager($this->get('doctrine')->getManager());
    }
    private function getActiviteManager()
    {
        return new ActiviteManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/stage", name="stage_index")
     */
    public function indexAction()
    {
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        // Obtention des stages
        $stages = $this->getManager()->loadStages($user->getLogin());

        return $this->render('stage/index.html.twig', array("arrayStages" => $stages));
    }

    /**
     * @Route("/stage/count", name="stage_count")
     */
    public function countAction()
    {
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        $count = $this->getManager()->countStages($user); //->getLogin()

        return new JsonResponse(array('count' => $count));
    }

    /**
     * @Route("/stage/add", name="stage_add")
     */
    public function addAction(Request $request)
    {
        // Création d'un nouveau stage
        $stage = new Stage();

        // Création du modèle du formulaire qui est lié à l'entité stage
        $model = $this->get('form.factory')->create(StageType::class, $stage);
        // Obtention du manager
        $manager = $this->getManager();

        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // Attachement du modèle à l'objet "request"
            $model->handleRequest($request);
            // Validation du modèle
            if ($model->isValid())
            {
                // Le login est celui de l'utilisateur connecté
                $stage->setLogin($this->getUser());
                // La date de modification
                $stage->setDatemodif(new \DateTime('now'));

                // Obtention du fichier
                $file = $stage->getEntrepriseLogo();
                if ($file) {
                    // Generate a unique name for the file before saving it
                    $fileName = 'logo'. $stage->getId() . '.' . $file->guessExtension();

                    // Move the file to the directory where brochures are stored
                    $file->move(
                        $this->getParameter('entrepriselogo_directory'),
                        $fileName
                    );

                    // Update the 'brochure' property to store the PDF file name
                    // instead of its contents
                    $stage->setEntrepriseLogo($fileName);
                }

                $typologies = $manager->loadTypologies();

                // Obtention des situations obligatoires: Typologie
                $mandatory = $request->request->get('mandatory');
                $manager->saveTypologies($stage, $mandatory);

                // Validation de l'entité
                $manager->saveStage($stage);

                return $this->redirectToRoute('stage_edit', array('id' => $stage->getId(),
                    'typologies' => $typologies));
            }
        }

        return $this->render('stage/add.html.twig', array('form' => $model->createView()));
    }

    /**
     * @Route("/stage/edit/{id}/{page}", defaults={"page" = 1},name="stage_edit")
     */
    public function editAction(Request $request, $id, $page)
    {
        // Obtention du manager
        $manager = $this->getManager();
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        // Recherche du stage
        if (!$stage = $manager->loadStage($id, $user->getLogin()))
        {
            return $this->render("TwigBundle/views/Exception/error404.html.twig");
        }

        // Création du modèle du formulaire
        $model = $this->get('form.factory')->create(StageType::class, $stage);
        // Obtention du manager
        $manager = $this->getManager();

        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // Conserver l'image actuelle
            $originalFileName = $stage->getEntrepriseLogo();

            // Attachement du modèle à l'objet "request"
            $model->handleRequest($request);
            // Validation du modèle
            if ($model->isValid())
            {
                // Obtention du fichier
                $file = $stage->getEntrepriseLogo();
                if ($file) {
                    // Generate a unique name for the file before saving it
                    $fileName = 'logo'. $stage->getId() . '.' . $file->guessExtension();

                    // Move the file to the directory where brochures are stored
                    $file->move(
                        $this->getParameter('entrepriselogo_directory'),
                        $fileName
                    );

                    // Update the 'brochure' property to store the PDF file name
                    // instead of its contents
                    $stage->setEntrepriseLogo($fileName);
                }
                else {
                    $stage->setEntrepriseLogo($originalFileName);
                }

                // Obtention des situations obligatoires: Typologie
                $mandatory = $request->request->get('mandatory');
                $manager->saveTypologies($stage, $mandatory);

                // Validation de l'entité
                $manager->saveStage($stage);
            }
        }

        // Obtention des activités
        $intitulesActivites = $manager->loadStageIntitules($id);
        // Typologies
        $typologies = $manager->loadTypologies();

        return $this->render('stage/edit.html.twig', array('form' => $model->createView(),
                             'stage' => $stage, 'page' => $page, 'intitulesActivites' => $intitulesActivites,
                             'typologies' => $typologies));
    }

    /**
     * @Route("/stage/delete", name="stage_delete")
     */
    public function deleteAction(Request $request) {
        // Si l'utilisateur appelle bien la suppresion en AJAX - POST
        // Récupération des infos
        $idStage = $request->request->get('idStage');

        if ($request->getMethod() == 'POST') {

            // Obtention du manager
            $manager = $this->getManager();
            // Obtention de l'utilisateur connecté
            $user = $this->getUser();
            // Recherche du stage
            if ($stage = $manager->loadStage($idStage, $user->getLogin())) {
                $message = "Le stage a ete supprimé";
                $status = 1;
                // Suppression du film
                try {
                    $manager->removeStage($stage);
                } catch (\Exception $e) {
                    $message = sprintf("L'erreur suivante est survenue lors de la suppression du stage: %s",
                        $e->getMessage());
                    $status = -1;
                }
            } else {
                $message = "L'intitulé n'existe pas";
                $status = -1;
            }
        }
        else
        {
            $message = "L'appel de la méthode de suppression est incorrecte";
            $status = $id = -1;
        }

        // Retour du résultat en Json
        /*$response = new Response(json_encode(array('status' => $status, 'message' => $message, 'id' => $idStage)));
        $response->headers->set('Content-Type', 'application/json');
        return $response;*/
        return new JsonResponse(array('status' => $status, 'message' => $message, 'id' => $idStage));
    }

    /**
     * @Route("/stage/addIntitule", name="stage_intitule_add")
     */
    public function addIntituleAction(Request $request) {

        $idStage = -1;
        $idIntitule = -1;

        // Si l'utilisateur appelle bien l'ajout en AJAX - POST
        if ($request->getMethod() == 'POST') {

            // Obtention du manager
            $manager = $this->getManager();

            // Récupération des infos
            $idStage = $request->request->get('idStage');
            $intitule = $request->request->get('intitule');
            // Obtention de l'utilisateur connecté
            $user = $this->getUser();

            // Recherche du stage
            if ($stage = $manager->loadStage($idStage, $user->getLogin()))
            {
                $message = "l'intitulé a été ajouté";
                $status = 1;

                // Création de l'intitulé
                try {
                    $idIntitule = $manager->addStageIntitule($idStage, $intitule);
                    if ($idIntitule == 0) {
                        $message = "Impossible d'ajouter l'intitulé";
                        $status = -1;
                    }
                } catch (\Exception $e) {
                    $message = sprintf("L'erreur suivante est survenue lors de l'ajout de l'intitulé: %s",
                        $e->getMessage());
                    $status = -1;
                }
            } else {
                $message = "L'intitulé n'existe pas";
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
                        'idStage' => $idStage, 'idIntitule' => $idIntitule, 'intitule' => $intitule));
    }

    /**
     * @Route("/stage/deleteIntitule", name="stage_intitule_delete")
     */
    public function deleteIntituleAction(Request $request) {
        // Récupération des infos
        $idStage = $request->request->get('idStage');
        $idIntitule = $request->request->get('idIntitule');

        $status = -1;
        // Si l'utilisateur appelle bien la suppresion en AJAX - POST
        if ($request->getMethod() == 'POST') {

            // Obtention du manager
            $manager = $this->getManager();
            // Recherche de l'intitulé
            if ($stageIntitule = $manager->loadStageIntitule($idStage, $idIntitule)) {
                $message = "L'intitulé a ete supprimé";
                $status = 1;
                // Suppression du film
                try {
                    $manager->removeStageIntitule($stageIntitule);
                } catch (\Exception $e) {
                    $message = sprintf("L'erreur suivante est survenue lors de la suppression de l'intitulé: %s",
                        $e->getMessage());
                    $status = -1;
                }
            } else {
                $message = "L'intitulé n'existe pas";
                $status = -1;
            }
        }
        else
        {
            $message = "L'appel de la méthode de suppression est incorrecte";
            $status = $id = -1;
        }

        // Retour du résultat en Json
        /*$response = new Response(json_encode(array('status' => $status, 'message' => $message, 'idStage' => $idStage, 'idIntitule' => $idIntitule)));
        $response->headers->set('Content-Type', 'application/json');
        return $response;*/
        return new JsonResponse(array('status' => $status, 'message' => $message, 'idStage' => $idStage, 'idIntitule' => $idIntitule));
    }

    /**
     * @Route("/stage/editIntitule/{id}/{idintitule}", name="stage_edit_intitule")
     */
    public function editIntituleAction(Request $request, $id, $idintitule)
    {
        // Obtention du manager
        $manager = $this->getManager();
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        // Recherche du stage
        if (!$stage = $manager->loadStage($id, $user->getLogin()))
        {
            return $this->render("TwigBundle/views/Exception/error404.html.twig");
        }
        // Recherche de l'intitule de ce stage
        $intitule = $manager->loadStageIntitule($id, $idintitule);
        // Obtention de toutes les activités
        $activites = $this->getActiviteManager()->loadActivites();

        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // Obtention de l'intitulé
            $libelle = $request->request->get('intitule');
            $intitule->setIntitule($libelle);
            // Validation de l'entité
            $manager->saveStageIntitule($intitule);
        }

        return $this->render('stage/editintitule.html.twig', array('stage' => $stage, 'intitule' => $intitule,
            'activites' => $activites, 'idParcours' => $user->getNumparcours()->getId()));
    }


    /**
     * @Route("/stage/addactivite", name="stage_addactivite")
     */
    public function addActiviteAction(Request $request)
    {
        $idActivite = 0;
        $status = -1;

        // Obtention de l'objet "request"
        //$request = $this->get('request');
        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // Récupération de l'ID du stage à supprimer
            $idActivite = $request->request->get('id');
            $idStage = $request->request->get('idstage');
            $idIntitule = $request->request->get('idintitule');

            // Obtention du manager
            $manager = $this->getManager();
            // Recherche du stage intitule
            if ($stage = $manager->loadStageIntitule($idStage, $idIntitule)) {
                $status = 1;
                // Ajout de l'activité
                try
                {
                    $manager->addStageActivite($idStage, $idIntitule, $idActivite);
                }
                catch (\Exception $e)
                {
                    $status = -1;
                }
            }

        }

        // Retour du résultat en Json
        return new JsonResponse(array('status' => $status, 'idActivite' => $idActivite));
    }

    /**
     * @Route("/stage/removeactivite", name="stage_removeactivite")
     */
    public function removeActiviteAction(Request $request)
    {
        $idActivite = 0;
        $status = -1;

        // Si l'utilisateur soumet le formulaire
        if ($request->getMethod() == 'POST')
        {
            // Récupération de l'ID du stage à supprimer
            $idActivite = $request->request->get('id');
            $idStage = $request->request->get('idstage');
            $idIntitule = $request->request->get('idintitule');

            // Obtention du manager
            $manager = $this->getManager();
            // Recherche du stage
            if ($stage = $manager->loadStageIntitule($idStage, $idIntitule)) {
                $status = 1;
                // Ajout de l'activité
                try
                {
                    $manager->removeStageActivite($idStage, $idIntitule, $idActivite);
                }
                catch (\Exception $e)
                {
                    $status = -1;
                }
            }

        }

        // Retour du résultat en Json
        return new JsonResponse(array('status' => $status, 'idActivite' => $idActivite));
    }

}
