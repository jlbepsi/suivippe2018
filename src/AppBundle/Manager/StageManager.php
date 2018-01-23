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

}