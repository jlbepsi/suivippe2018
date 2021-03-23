<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 02/02/2017
 * Time: 11:50
 */

namespace AppBundle\Manager;

use AppBundle\Controller\Prof\Utils\UtilisateursSituations;
use AppBundle\Controller\Prof\Utils\UtilisateursSyntheses;
use AppBundle\Entity\Situation;
use AppBundle\Entity\UserLdap;
use AppBundle\Form\SituationSearchCriteria;
use AppBundle\Security\LdapUserProvider;
use Doctrine\ORM\EntityManager;
use Symfony\Component\HttpFoundation\Response;


class SyntheseManager
{
    protected $entityManager;

    public function __construct(EntityManager $em)
    {
        $this->entityManager = $em;
    }

    public function getEntityManager() {
        return $this->entityManager;
    }

    public function loadActivitesDomaine($idParcours)
    {
        $query = $this->entityManager->createQuery(
               'SELECT e
                    FROM AppBundle:Activite a, AppBundle:Evalue e, AppBundle:Parcours p, AppBundle:Epreuve ep
                    WHERE p.id = :idParcours
                      AND e.idparcours = p
                      AND e.idactivite = a
                      AND e.idepreuve = ep'
        )->setParameter('idParcours', $idParcours);
        $result = $query->getResult();

        // Probleme
        if ($idParcours == 1 or $idParcours == 2)
        {
            // Pour SISR
            $inValues = '(26,27)';
            if ($idParcours == 1)
                $inValues = '(35,36,40,41,42)'; // Pour SLAM
            $queryText = 'SELECT e
                    FROM AppBundle:Activite a, AppBundle:Evalue e, AppBundle:Epreuve ep
                    WHERE e.idactivite = a
                      AND e.idepreuve = ep
                      AND a.id in ' . $inValues;
            $query2 = $this->entityManager->createQuery($queryText);
            $result2 = $query2->getResult();

            foreach ($result2 as $item) {
                // Ajoute ssi l'id n'est pas présent
                $notFound = true;
                foreach($result as $line) {
                    if ($line->getIdactivite()->getId() == $item->getIdactivite()->getId()) {
                        $notFound = false;
                        break;
                    }
                }
                if ($notFound)
                    $result[] = $item;
            }
        }

        usort($result, function($e1, $e2)
        {
            return ($e1->getIdactivite()->getId() > $e2->getIdactivite()->getId());
        });

        return $result;
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

    public function loadProcessus()
    {
        $repository = $this->entityManager->getRepository('AppBundle:Processus');
        return $repository->findAll();
    }

    /**
     * @param LdapUserProvider $serviceLdap
     * @param string $classe
     * @return UserLdap[]
     */
    public function loadUtilisateursSyntheses($serviceLdap, $classe = null)
    {
        // Obtention des utilisateurs Ldap
        return $serviceLdap->loadUsersByClasse($classe);
    }

}