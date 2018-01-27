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
        // Obtention des situations
        $stages = $this->getManager()->loadStages($user->getLogin());

        return $this->render('stage/index.html.twig', array("arrayStages" => $stages));
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

                // Validation de l'entité
                $manager->saveStage($stage);

                return $this->redirectToRoute('stage_edit', array('id' => $stage->getId()));
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
                // Validation de l'entité
                $manager->saveStage($stage);
            }
        }

        // Obtention des activités
        $intitulesActivites = $manager->loadStageIntitulesActivites();

        return $this->render('stage/edit.html.twig', array('form' => $model->createView(),
                                'stage' => $stage, 'page' => $page, 'intitulesActivites' => $intitulesActivites));
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
                $status = 0;
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
        // Récupération des infos
        $idStage = $request->request->get('intitule');

        $idIntitule = -1;
        // Si l'utilisateur appelle bien la suppresion en AJAX - POST
        if ($request->getMethod() == 'POST') {

            // Obtention du manager
            $manager = $this->getManager();


            $message = "TEST OK";
            $status = 0;
            $idIntitule = 99;

            // Recherche de l'intitulé
            /*if ($stageIntitule = $manager->loadStageIntitule($idStage, $idIntitule)) {
                $message = "L'intitulé a ete supprimé";
                $status = 0;
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
            }*/
        }
        else
        {
            $message = "L'appel de la méthode de suppression est incorrecte";
            $status = $id = -1;
        }

        // Retour du résultat en Json
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

        return $this->render('stage/editintitule.html.twig', array('stage' => $stage, 'intitule' => $intitule, 'activites' => $activites));
    }

    /**
     * @Route("/stage/deleteIntitule", name="stage_intitule_delete")
     */
    public function deleteIntituleAction(Request $request) {
        // Récupération des infos
        $idStage = $request->request->get('idStage');
        $idIntitule = $request->request->get('idIntitule');

        // Si l'utilisateur appelle bien la suppresion en AJAX - POST
        if ($request->getMethod() == 'POST') {

            // Obtention du manager
            $manager = $this->getManager();
            // Recherche de l'intitulé
            if ($stageIntitule = $manager->loadStageIntitule($idStage, $idIntitule)) {
                $message = "L'intitulé a ete supprimé";
                $status = 0;
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
     * @Route("/stage/count", name="stage_count")
     */
    public function countAction()
    {
        // Obtention de l'utilisateur connecté
        $user = $this->getUser();
        $count = $this->getManager()->countStages($user->getLogin());

        return new JsonResponse(array('count' => $count));
    }

}
