<?php
/**
 * Created by PhpStorm.
 * User: epsi
 * Date: 08/12/17
 * Time: 09:21
 */

namespace AppBundle\Manager;


use AppBundle\Entity\Utilisateur;
use Doctrine\ORM\EntityManager;

class UtilisateurManager
{
    protected $entityManager;
    protected $repository;

    public function __construct(EntityManager $em)
    {
        $this->entityManager = $em;
        $this->repository = $em->getRepository('AppBundle:Utilisateur');
    }

    public function loadUser($login)
    {
        return $this->repository->find($login);
    }

    public function saveUser(Utilisateur $utilisateur)
    {
        $this->entityManager->persist($utilisateur);
        $this->entityManager->flush();
    }
}