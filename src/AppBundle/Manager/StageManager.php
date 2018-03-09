<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 06/02/2017
 * Time: 11:00
 */

namespace AppBundle\Manager;


use AppBundle\Controller\Prof\Utils\UtilisateursStages;
use AppBundle\Entity\Stage;
use AppBundle\Entity\Stageintitule;
use AppBundle\Entity\Stageintituleactivite;
use AppBundle\Entity\Utilisateur;
use Doctrine\ORM\EntityManager;

class StageManager
{
    protected $entityManager;
    protected $repository;
    protected $repositoryStageintitule;
    protected $repositoryActivites;
    protected $repositoryStageIntituleActivite;

    public function __construct(EntityManager $em)
    {
        $this->entityManager = $em;
        $this->repository = $em->getRepository('AppBundle:Stage');
        $this->repositoryActivites = null;
    }

    /**
     * @return \Doctrine\ORM\EntityRepository|null
     */
    private function getRepositoryActivites()
    {
        if ($this->repositoryActivites == null)
            $this->repositoryActivites = $this->entityManager->getRepository('AppBundle:Activite');
        return $this->repositoryActivites;
    }

    /**
     * @return \Doctrine\ORM\EntityRepository
     */
    private function getRepositoryStageIntituleActivite()
    {
        if ($this->repositoryStageIntituleActivite == null)
            $this->repositoryStageIntituleActivite = $this->entityManager->getRepository('AppBundle:Stageintituleactivite');
        return $this->repositoryStageIntituleActivite;
    }

    /**
     * @return \AppBundle\Entity\Stage[]
     */
    public function loadAllStages()
    {
        return $this->repository->findAll();
    }

    /**
     * @param $login string
     * @return \AppBundle\Entity\Stage[]
     */
    public function loadStages($login)
    {
        //return $this->repository->findBy(array("login" => $login));
        return $this->repository->loadStage($login);
    }

    /**
     * @param $id integer
     * @param $login string
     * @return Stage|null
     */
    public function loadStage($id, $login)
    {
        return $this->repository->findOneBy(array("id" => $id, "login" => $login));
    }

    /**
     * @param $id integer
     * @return Stage|null
     */
    public function loadSingleStage($id)
    {
        return $this->repository->find($id);
    }

    /**
     * @param \AppBundle\Entity\Utilisateur $login
     * @return integer
     */
    public function countStages(Utilisateur $login)
    {
        return $this->repository->countStages($login);
    }

    /**
     * @param \AppBundle\Entity\Stage $stage
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function saveStage(Stage $stage)
    {
        $this->entityManager->persist($stage);
        $this->entityManager->flush();
    }

    /**
     * @param \AppBundle\Entity\Stage $stage
     * @throws \Doctrine\ORM\OptimisticLockException
     */
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

    /**
     * @param $idStage integer
     * @return Stageintitule[]|array
     */
    public function loadStagesIntitules()
    {
        if ($this->repositoryStageintitule == null)
            $this->repositoryStageintitule = $this->entityManager->getRepository('AppBundle:Stageintitule');

        return $this->repositoryStageintitule->findAll();
    }

    /**
     * @param $idStage integer
     * @return Stageintitule[]|array
     */
    public function loadStageIntitules($idStage)
    {
        if ($this->repositoryStageintitule == null)
            $this->repositoryStageintitule = $this->entityManager->getRepository('AppBundle:Stageintitule');

        return $this->repositoryStageintitule->findby(array("idstage" => $idStage));
    }

    /**
     * @param \AppBundle\Entity\Utilisateur $login
     * @return Stageintitule[]|array
     */
    public function loadStageIntitulesUser(Utilisateur $login)
    {
        if ($this->repositoryStageintitule == null)
            $this->repositoryStageintitule = $this->entityManager->getRepository('AppBundle:Stageintitule');

        return $this->repositoryStageintitule->loadStageIntitulesUser($login);
    }

    /**
     * @param $id integer
     * @param $idintitule integer
     * @return Stageintitule|null
     */
    public function loadStageIntitule($idStage, $idintitule)
    {
        if ($this->repositoryStageintitule == null)
            $this->repositoryStageintitule = $this->entityManager->getRepository('AppBundle:Stageintitule');

        return $this->repositoryStageintitule->find(array("idstage" => $idStage, "idintitule" => $idintitule));
    }

    /**
     * @param \AppBundle\Entity\Stageintitule $stageIntitule
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function removeStageIntitule(Stageintitule $stageIntitule)
    {
        // Supprime toutes les activtés

        // puis supprime l 'intitulé du stage
        $this->entityManager->remove($stageIntitule);
        $this->entityManager->flush();
    }

    /**
     * @param \AppBundle\Entity\Stageintitule $stageIntitule
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function saveStageIntitule(Stageintitule $stageIntitule)
    {
        $this->entityManager->persist($stageIntitule);
        $this->entityManager->flush();
    }

    /**
     * @param $idStage integer
     * @param $intitule string
     * @return int
     */
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

    /**
     * @param $idStage integer
     * @param $idIntitule integer
     * @param $idActivite integer
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function addStageActivite($idStage, $idIntitule, $idActivite)
    {
        $repository = $this->getRepositoryActivites();
        $activite = $repository->find($idActivite);

        $stageIntituleActivite = new Stageintituleactivite();
        $stageIntituleActivite->setIdstage($idStage);
        $stageIntituleActivite->setIdintitule($idIntitule);
        $stageIntituleActivite->setIdactivite($activite);

        $this->entityManager->persist($stageIntituleActivite);
        $this->entityManager->flush();
    }

    /**
     * @param $idStage integer
     * @param $idIntitule integer
     * @param $idActivite integer
     * @throws \Doctrine\ORM\OptimisticLockException
     */
    public function removeStageActivite($idStage, $idIntitule, $idActivite)
    {
        $repository = $this->getRepositoryStageIntituleActivite();
        $stageIntituleActivite = $repository->findOneBy(array("idstage" => $idStage, "idintitule" => $idIntitule,
                                                "idactivite" => $idActivite));

        if ($stageIntituleActivite)
        {
            $this->entityManager->remove($stageIntituleActivite);
            $this->entityManager->flush();
        }
    }



    /*
     *
     * TYPOLOGIE
     *
     */

    /**
     * @return \AppBundle\Entity\Typologie[]
     */
    public function loadTypologies()
    {
        $repository = $this->entityManager->getRepository('AppBundle:Typologie');

        return $repository->findAll();
    }

    /**
     * @param \AppBundle\Entity\Stage $stage
     * @param $arrayIdTypologies integer[]
     */
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

    /**
     *
     * PROF
     *
     */

    /**
     * @return UtilisateursStages
     */
    public function loadUtilisateursStages()
    {
        /**
         *
         * SELECT * FROM utilisateur us LEFT JOIN stage st ON (st.login = us.login) WHERE us.classe ='B1' OR us.classe ='B2'
         *
         */

        $utilisateursStages = new UtilisateursStages();
        // On charge toutes les stages
        $stages = $this->loadAllStages();
        $utilisateursStages->setStages($stages);
        // On charge toutes les intitulés de stage
        $stagesIntitules = $this->loadStagesIntitules();
        foreach ($stagesIntitules as $stagesIntitule) {
            $utilisateursStages->addStageIntitule($stagesIntitule);
        }


        // On charge tous les utilisateurs qui n'ont pas de situations
        $repositoryUtilisateur = $this->entityManager->getRepository('AppBundle:Utilisateur');
        $utilisateurs = $repositoryUtilisateur->findEtudiants();
        $utilisateursStages->setUtilisateursSansStage($utilisateurs);

        return $utilisateursStages;
    }

}