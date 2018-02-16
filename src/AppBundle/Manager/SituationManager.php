<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 02/02/2017
 * Time: 11:50
 */

namespace AppBundle\Manager;

use AppBundle\Entity\Situation;
use AppBundle\Entity\Situatione4;
use AppBundle\Form\SituationSearchCriteria;
use Doctrine\ORM\EntityManager;


class SituationManager
{
    protected $entityManager;
    protected $repository;
    protected $repositoryActivites;

    public function __construct(EntityManager $em)
    {
        $this->entityManager = $em;
        $this->repository = $em->getRepository('AppBundle:Situation');
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

    public function loadAllSituations()
    {
        return  $this->repository->findAll();
    }

    public function loadSituations($login)
    {
        $entities = $this->repository->findBy(array("login" => $login));
        return $entities;
    }
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
     * Load Situation entity
     *
     * @param Integer $situationId
     */
    public function loadSituation($situationId, $login)
    {
        return $this->repository->findOneBy(array("reference" => $situationId, "login" => $login));
    }

    /**
     * Save Situation entity
     *
     * @param Situation $situation
     */
    public function saveSituation(Situation $situation)
    {
        $this->entityManager->persist($situation);
        $this->entityManager->flush();
    }

    /**
     * Save Situation entity
     *
     * @param Situation $situatione4
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
     */
    public function removeSituation(Situation $situation)
    {
        $this->entityManager->remove($situation);
        $this->entityManager->flush();
    }


    /**
     * Remove Situatione4 entity
     *
     * @param Situatione4 $situatione4
     */
    public function removeSituationE4(Situatione4 $situatione4)
    {
        $this->entityManager->remove($situatione4);
        $this->entityManager->flush();
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
}