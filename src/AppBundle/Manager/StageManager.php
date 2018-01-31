<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 06/02/2017
 * Time: 11:00
 */

namespace AppBundle\Manager;


use AppBundle\Entity\Stage;
use AppBundle\Entity\Stageintitule;
use Doctrine\ORM\EntityManager;

class StageManager
{
    protected $entityManager;
    protected $repository;
    protected $repositoryStageintitule;

    public function __construct(EntityManager $em)
    {
        $this->entityManager = $em;
        $this->repository = $em->getRepository('AppBundle:Stage');
        $this->repositoryActivites = null;
    }

    public function loadStages($login)
    {
        $entities = $this->repository->findBy(array("login" => $login));
        return $entities;
    }

    public function loadStage($id, $login)
    {
        return $this->repository->findOneBy(array("id" => $id, "login" => $login));
    }

    public function countStages($login)
    {
        return $this->repository->countStages($login);
    }

    public function saveStage(Stage $stage)
    {
        $this->entityManager->persist($stage);
        $this->entityManager->flush();
    }

    public function removeStage(Stage $stage)
    {
        $this->entityManager->remove($stage);
        $this->entityManager->flush();
    }

    /**
     *
     * Intitule
     *
     **/
    public function loadStageIntitule($id, $idintitule)
    {
        if ($this->repositoryStageintitule == null)
            $this->repositoryStageintitule = $this->entityManager->getRepository('AppBundle:Stageintitule');

        return $this->repositoryStageintitule->find(array("idstage" => $id, "idintitule" => $idintitule));
    }
    public function removeStageIntitule(Stageintitule $stageIntitule)
    {
        $this->entityManager->remove($stageIntitule);
        $this->entityManager->flush();
    }
    public function saveStageIntitule(Stageintitule $stageIntitule)
    {
        $this->entityManager->persist($stageIntitule);
        $this->entityManager->flush();
    }
    public function addStageIntitule($idStage, $intitule)
    {
        $em = $this->entityManager->getConnection();

        $newidIntitule = 0;
        try
        {
            // prepare statement
            $stmt = $em->prepare("SELECT addStageIntitule(:pIdStage, :pIntitule) AS newIdIntitule");
            $stmt->bindValue(':pIdStage', $idStage);
            $stmt->bindValue(':pIntitule', $intitule);
            // execute and fetch one result
            $stmt->execute();

            $result = $stmt->fetch();
            $newidIntitule = intval($result["newIdIntitule"]);
        }
        catch (\Exception $exception)
        {
        }

        return $newidIntitule;
    }

    /**
     *
     * Activitées
     *
     **/
    public function loadStageIntitulesActivites()
    {
        if ($this->repositoryStageintitule == null)
            $this->repositoryStageintitule = $this->entityManager->getRepository('AppBundle:Stageintitule');

        return $this->repositoryStageintitule->findAll();
    }
    public function loadStageIntitulesActivitesUser($login)
    {
        if ($this->repositoryStageintitule == null)
            $this->repositoryStageintitule = $this->entityManager->getRepository('AppBundle:Stageintitule');

        return $this->repositoryStageintitule->loadStageIntitulesUser($login);
    }


    /*
     *
     * TYPOLOGIE
     *
     */
    public function loadTypologies()
    {
        $repository = $this->entityManager->getRepository('AppBundle:Typologie');

        return $repository->findAll();
    }
    public function saveTypologies(Stage $stage, $arrayIdTypologies)
    {
        // On enlève toutes les situations
        $stage->removeAllCodes();
        if ($arrayIdTypologies == null)
            return;

        $repository = $this->entityManager->getRepository('AppBundle:Typologie');
        foreach ($arrayIdTypologies as $idTypo) {
            $typologie = $repository->find($idTypo);
            if ($typologie != null) {
                $stage->addCode($typologie);
            }
        }
    }

}