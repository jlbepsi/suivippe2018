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
     * @param $analyseSituationActivite integer
     * @return UtilisateursSituations
     */
    public function loadUtilisateursSituations($analyseSituationActivite, $classe = null)
    {
        /**
         *
         * SELECT * FROM utilisateur us LEFT JOIN situation si ON (si.login = us.login) WHERE us.classe ='B1' OR us.classe ='B2'
         *
         */

        $utilisateursSituations = new UtilisateursSituations();
        $utilisateursSituations->setAnalyseSituationActivite($analyseSituationActivite);

        // On charge toutes les situations
        if ($classe != null)
        {
            $query = $this->getEntityManager()->createQuery(
                'SELECT si
                    FROM AppBundle:Situation si, AppBundle:Utilisateur us
                    WHERE si.login = us
                      AND us.classe = :pClasse
                    ORDER BY us.nom, us.prenom'
            )->setParameter('pClasse', $classe);
        }
        else
        {

            $query = $this->getEntityManager()->createQuery(
                'SELECT si
                    FROM AppBundle:Situation si, AppBundle:Utilisateur us
                    WHERE si.login = us
                    ORDER BY us.nom, us.prenom'
            );
        }
        $situations = $query->getResult();

        $utilisateursSituations->setSituations($situations);

        // On charge tous les utilisateurs qui n'ont pas de situations
        $repositoryUtilisateur = $this->entityManager->getRepository('AppBundle:Utilisateur');
        $utilisateurs = $repositoryUtilisateur->findEtudiants($classe);
        $utilisateursSituations->setUtilisateursSansSituation($utilisateurs);

        return $utilisateursSituations;
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
     * Load Situation entity
     *
     * @param Integer $situationId
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
     * @param Situatione4|null $situatione4
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
     * @param Utilisateur $prof
     * @param $date \DateTime
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function addSituationCommentaire(Situation $situation, $commentaire, Utilisateur $prof, $date)
    {
        $repository = $this->repositoryCommentaires;
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
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function saveCommentaire($commentaire)
    {
        $this->entityManager->persist($commentaire);
        $this->entityManager->flush();
    }

    /**
     * @param \AppBundle\Entity\Commentaire $commentaire
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