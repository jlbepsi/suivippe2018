<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 07/02/2017
 * Time: 11:23
 */

namespace AppBundle\Manager;

use AppBundle\Entity\Activite;
use Doctrine\ORM\EntityManager;

class ActiviteManager
{
    protected $entityManager;
    protected $repository;

    public function __construct(EntityManager $em)
    {
        $this->entityManager = $em;
        $this->repository = $em->getRepository('AppBundle:Activite');
    }

    public function loadActivites()
    {
        $entities = $this->repository->findAll();
        return $entities;
    }
    public function loadActivite($id)
    {
        return $this->repository->find($id);
    }
}