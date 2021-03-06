<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 02/02/2017
 * Time: 11:50
 */

namespace AppBundle\Manager;

use AppBundle\Controller\Prof\Utils\UtilisateursSituations;
use AppBundle\Entity\Commentaire;
use AppBundle\Entity\Situation;
use AppBundle\Entity\Situatione4;
use AppBundle\Entity\Utilisateur;
use AppBundle\Form\SituationSearchCriteria;
use AppBundle\Security\LdapUserProvider;
use Doctrine\ORM\EntityManager;


class SituationManager
{
    protected $entityManager;
    protected $repository;
    protected $repositoryCommentaires;
    protected $repositoryActivites;

    public function __construct(EntityManager $em)
    {
        $this->entityManager = $em;
        $this->repository = $em->getRepository('AppBundle:Situation');
        $this->repositoryCommentaires = $em->getRepository('AppBundle:Commentaire');
        $this->repositoryActivites = null;
    }

    public function getEntityManager() {
        return $this->entityManager;
    }

    private function getRepositoryActivites()
    {
        if ($this->repositoryActivites == null)
            $this->repositoryActivites = $this->entityManager->getRepository('AppBundle:Activite');
        return $this->repositoryActivites;
    }

    /**
     * @param LdapUserProvider $serviceLdap
     * @param $analyseSituationActivite integer
     * @return UtilisateursSituations
     */
    public function loadUtilisateursSituations($serviceLdap, $analyseSituationActivite, $classe = null)
    {
        // Liste des utilisateurs et de leurs situations
        $utilisateursSituations = new UtilisateursSituations();

        // Obtention de tous les situations
        $situations = $this->loadAllSituations();
        // Obtention des utilisateurs Ldap
        $users = $serviceLdap->loadUsersByClasse($classe);


        // Répartition utilisateurs / stages
        $utilisateursSituations->compute($users, $situations);

        $utilisateursSituations->setAnalyseSituationActivite($analyseSituationActivite);

        return $utilisateursSituations;
    }


    public function countAllSituations()
    {
        $qb = $this->repository->createQueryBuilder('s');
        $qb->select('COUNT(s)');

        return $qb
            ->getQuery()
            ->getSingleScalarResult();
    }

    /**
     * @param $login string
     * @return integer
     * @throws \Doctrine\ORM\NoResultException
     * @throws \Doctrine\ORM\NonUniqueResultException
     */
    public function countSituations($login)
    {
        $qb = $this->repository->createQueryBuilder('s');
        $qb->select('COUNT(s)');
        $qb->where('s.login=:userLogin');

        return $qb
            ->getQuery()
            ->setParameter(":userLogin", $login)
            ->getSingleScalarResult();
    }

    /**
     * @return /AppBundle/Entity/Situation[]
     */
    public function loadAllSituations()
    {
        return $this->repository->findAll();
    }

    /**
     * @param $login
     * @return /AppBundle/Entity/Situation[]
     */
    public function loadSituations($login)
    {
        $entities = $this->repository->findBy(array("login" => $login));
        return $entities;
    }

    /**
     * @param SituationSearchCriteria $situationSearchCriteria
     * @param $login
     * @return /AppBundle/Entity/Situation[]
     */
    public function loadSituationsWhere(SituationSearchCriteria $situationSearchCriteria, $login)
    {
        $qb = $this->repository->createQueryBuilder('s');
        $qb->where('s.login=:userLogin');

        $libelle = $situationSearchCriteria->libelle;
        if (! empty($libelle)) {
            $libelle = '%'.$libelle.'%';
            $qb->andWhere('s.libelle LIKE :libelle')
                ->setParameter('libelle', $libelle);
        }
        $descriptif = $situationSearchCriteria->descriptif;
        if (! empty($descriptif)) {
            $descriptif = '%'.$descriptif.'%';
            $qb->andWhere('s.descriptif LIKE :descriptif')
                ->setParameter(':descriptif', $descriptif);
        }
        $date = $situationSearchCriteria->date;
        if (! empty($date)) {
            $qb->andWhere('s.datedebut <= :date AND s.datefin >= :date')
                ->setParameter('date', $date);
        }

        return $qb
            ->getQuery()
            ->setParameter(":userLogin", $login)
            ->getResult();
    }

    /**
     * Load Situation entity
     *
     * @param Integer $situationId
     * @return Situation|object|null
     */
    public function loadSituation($situationId, $login)
    {
        return $this->repository->findOneBy(array("reference" => $situationId, "login" => $login));
    }

    /**
     * Load Situation entity
     *
     * @param $situationId
     * @return Situation|null
     */
    public function loadSingleSituation($situationId)
    {
        return $this->repository->find($situationId);
    }

    /**
     * Save Situation entity
     *
     * @param Situation $situation
     * @throws \Doctrine\ORM\ORMException
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function saveSituation(Situation $situation)
    {
        $this->entityManager->persist($situation);
        $this->entityManager->flush();
    }

    /**
     * Save Situation entity
     *
     * @param Situatione4 $situatione4
     * @throws \Doctrine\ORM\ORMException
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function saveSituationE4(Situatione4 $situatione4)
    {
        $this->entityManager->persist($situatione4);
        $this->entityManager->flush();
    }

    /**
     * Remove Situation entity
     *
     * @param Situation $situation
     * @throws \Doctrine\ORM\ORMException
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function removeSituation(Situation $situation)
    {
        $this->entityManager->remove($situation);
        $this->entityManager->flush();
    }


    /**
     * Remove Situatione4 entity
     *
     * @param Situatione4|null $situatione4
     * @throws \Doctrine\ORM\ORMException
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function removeSituationE4(Situatione4 $situatione4)
    {
        if ($situatione4)
        {
            $this->entityManager->remove($situatione4);
            $this->entityManager->flush();
        }
    }


    /*
     *
     * ACTIVITE
     *
     */

    public function loadSituationActivites()
    {
        $repository = $this->getRepositoryActivites();

        $entities = $repository->findAll();
        return $entities;
    }
    public function addSituationActivite(Situation $situation, $idActivite)
    {
        $repository = $this->getRepositoryActivites();
        $activite = $repository->find($idActivite);

        $activite->addRefsituation($situation);

        $this->entityManager->persist($activite);
        $this->entityManager->flush();
    }
    public function removeSituationActivite(Situation $situation, $idActivite)
    {
        $repository = $this->getRepositoryActivites();
        $activite = $repository->find($idActivite);

        $activite->removeRefsituation($situation);
        $this->entityManager->persist($activite);
        $this->entityManager->flush();
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
    public function saveTypologies(Situation $situation, $arrayIdTypologies)
    {
        // On enlève toutes les situations
        $situation->removeAllCodes();
        if ($arrayIdTypologies == null)
            return;

        $repository = $this->entityManager->getRepository('AppBundle:Typologie');
        foreach ($arrayIdTypologies as $idTypo) {
            $typologie = $repository->find($idTypo);
            if ($typologie != null) {
                $situation->addCode($typologie);
            }
        }
    }

    /*
     *
     * COMMENTAIRES
     *
     *
     */

    /**
     * Load Commentaire entities
     */

    /**
     * Load Commentaire entities
     */
    public function countCommentaires($login)
    {
        $qb = $this->repositoryCommentaires->createQueryBuilder('c');
        $qb->select('COUNT(c)');
        $qb->where('c.loginprofesseur=:profLogin');

        return $qb
            ->getQuery()
            ->setParameter(":profLogin", $login)
            ->getSingleScalarResult();
    }

    public function loadCommentaires($situationId)
    {
        //return $this->repositoryCommentaires->findBy(array("refsituation" => $situationId));

        $qb = $this->repositoryCommentaires->createQueryBuilder('c');
        $qb->where('c.refsituation=:refSituation')
            ->orderBy('c.datecommentaire', 'DESC');

        return $qb
            ->getQuery()
            ->setParameter(":refSituation", $situationId)
            ->getResult();
    }

    public function loadCommentaire($id)
    {
        return $this->repositoryCommentaires->find($id);
    }

    /**
     * @param Situation $situation
     * @param $commentaire string
     * @param string $prof
     * @param $date \DateTime
     * @return int
     * @throws \Doctrine\ORM\ORMException
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function addSituationCommentaire(Situation $situation, $commentaire, $prof, $date)
    {
        $entity = new Commentaire();
        $entity->setRefsituation($situation);
        $entity->setCommentaire($commentaire);
        $entity->setLoginprofesseur($prof);
        $entity->setDatecommentaire($date);

        $this->entityManager->persist($entity);
        $this->entityManager->flush();

        return $entity->getNumero();
    }

    /**
     * @param \AppBundle\Entity\Commentaire $commentaire
     * @throws \Doctrine\ORM\ORMException
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function saveCommentaire($commentaire)
    {
        $this->entityManager->persist($commentaire);
        $this->entityManager->flush();
    }

    /**
     * @param \AppBundle\Entity\Commentaire $commentaire
     * @throws \Doctrine\ORM\ORMException
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function removeCommentaire($commentaire)
    {
        $this->entityManager->remove($commentaire);
        $this->entityManager->flush();
    }

    /*
     *
     * FRAMEWORK
     *
     */
    public function loadFramework()
    {
        $repository = $this->entityManager->getRepository('AppBundle:Framework');
        return $repository->findAll();
    }
}