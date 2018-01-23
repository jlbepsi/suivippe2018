<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 07/02/2017
 * Time: 15:44
 */

namespace AppBundle\Manager;


class GenericManager
{
    protected $entityManager;
    protected $repository;

    public function __construct($em, $entityName)
    {
        $this->entityManager = $em;
        $this->repository = $em->getRepository('AppBundle:'.$entityName);
    }

    public function load($id)
    {
        return $this->repository->find($id);
    }

    public function save($entity)
    {
        $this->entityManager->persist($entity);
        $this->entityManager->flush();
    }

    public function remove($entity)
    {
        $this->entityManager->remove($entity);
        $this->entityManager->flush();
    }
}