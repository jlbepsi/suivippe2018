<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 22/01/19
 * Time: 16:21
 */

namespace AppBundle\Manager;


use AppBundle\Entity\Utilisateur;
use Doctrine\ORM\EntityManager;

class UtilisateursAPIManager
{
    protected $entityManager;
    protected $repository;
    
    public function __construct(EntityManager $em)
    {
        $this->entityManager = $em;
        $this->repository = $em->getRepository('AppBundle:Utilisateur');
    }

    /**
     * @return \AppBundle\Entity\Utilisateur[]
     */
    public function loadAllUtilisateurs()
    {
        $query = $this->entityManager->createQuery(
            "SELECT u.login, u.type, u.classe, u.nom, u.prenom, u.mail, u.roles, p.id as numparcours
                 FROM AppBundle:Utilisateur u, AppBundle:Parcours p
                 WHERE u.numparcours = p.id"
        );
        return $query->getArrayResult();
    }

    /**
     * @param $login string
     * @return \AppBundle\Entity\Utilisateur
     */
    public function loadUtilisateurs($login)
    {
        $query = $this->entityManager->createQuery(
            "SELECT u.login, u.type, u.classe, u.nom, u.prenom, u.mail, u.roles, p.id as numparcours
                 FROM AppBundle:Utilisateur u, AppBundle:Parcours p
                 WHERE u.login = :pLogin AND u.numparcours = p.id"
        );
        $query->setParameter(":pLogin", $login);
        return $query->getSingleResult();
    }
    
    /**
     * @param \AppBundle\Entity\Utilisateur $utilisateur
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function saveUtilisateur(Utilisateur $utilisateur)
    {
        $this->entityManager->persist($utilisateur);
        $this->entityManager->flush();
    }

    /**
     * @param \AppBundle\Entity\Utilisateur $utilisateur
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function removeUtilisateur(Utilisateur $utilisateur)
    {
        $stmt = $this->entityManager
            ->getConnection()
            ->prepare('CALL deleteUtilisateur (:login);');
        $stmt->bindValue('login', $utilisateur->getLogin());
        $stmt->execute();
    }

}