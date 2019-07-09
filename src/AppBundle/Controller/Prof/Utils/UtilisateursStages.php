<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 15/02/18
 * Time: 10:22
 */

namespace AppBundle\Controller\Prof\Utils;

use AppBundle\Entity\UserLdap;

class UtilisateursStages
{
    /**
     * tableau clé (login), valeur (UserLdap)
     *
     * @var \Doctrine\Common\Collections\Collection
     */
    private $utilisateurs;


    public function __construct()
    {
        $this->utilisateurs = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getUtilisateurs()
    {
        return $this->utilisateurs;
    }


    /**
     * Ajoute les utilisateurs et créé la listes des stages associés aux utilisateurs
     *
     * @param $utilisateurs UserLdap[]
     * @param $stages \AppBundle\Entity\Stage[]
     */
    public function compute($utilisateurs, $stages)
    {
        // Fixe les utilisateurs par clé: login
        foreach ($utilisateurs as $utilisateur)
        {
            if (! $this->utilisateurs->containsKey($utilisateur->getLogin())) {
                $this->utilisateurs->set($utilisateur->getLogin(), new UtilisateurStages($utilisateur));
            }
        }

        // Répartis les stages par utilisateurs

        // Parcours des stages
        foreach ($stages as $stage)
        {
            // Obtention de l'objet UtilisateurStages
            $utilisateurStages = $this->utilisateurs->get($stage->getLogin());
            if ($utilisateurStages != null)
            {
                $utilisateurStages->addStage($stage);

            } // Sinon l'utilisateur du stage n'existe plus, voir Liste des utilisateurs du contrôleur Prof???Controller
        }
    }



    /**
    public function setStages($stages)
    {
        $count = count($stages);
        $i = 0;
        while ($i < $count)
        {
            $stage = $stages[$i];
            $loginUtilisateur = $stage->getLogin();

            $utilisateurStages = new UtilisateurStages();
            $utilisateurStages->setUtilisateur($stage->getLogin());

            while ($i < $count && $stages[$i]->getLogin() == $loginUtilisateur)
            {
                $utilisateurStages->addStage($stages[$i]);
                $i++;
            }

            $this->utilisateurs[] = $utilisateurStages;
        }
    }

    /**
    public function setUtilisateursSansStage($utilisateurs)
    {
        foreach ($utilisateurs as $utilisateur)
        {
            if ($this->findUtilisateur($utilisateur->getLogin()) == null)
            {
                // Ajoute l'utilisateur sans stages
                $utilisateurStages = new UtilisateurStages();
                $utilisateurStages->setUtilisateur($utilisateur);
                $this->utilisateurs[] = $utilisateurStages;
            }
        }
        // Tri sur le nom puis prénom
        usort($this->utilisateurs, function($e1, $e2)
        {
            return ($e1->getUtilisateur()->getNom() . ' ' . $e1->getUtilisateur()->getPrenom() >
                $e2->getUtilisateur()->getNom() . ' ' . $e1->getUtilisateur()->getPrenom());
        });
    }

    /**
    private function findUtilisateur($login)
    {
        foreach ($this->utilisateurs as $utilisateurStages)
        {
            if ($utilisateurStages->getUtilisateur()->getLogin() === $login)
                return $utilisateurStages;
        }
        return null;
    }
     */

    /**
     * @param $stagesIntitule \AppBundle\Entity\Stageintitule[]
     */
    public function addStagesIntitules($stagesIntitules)
    {

        foreach ($stagesIntitules as $stagesIntitule)
        {
            // On recherche le stage d'après l'utilisateur
            $utilisateurStages = $this->utilisateurs->get($stagesIntitule->getIdstage()->getLogin());

            if ($utilisateurStages)
            {
                $stage = $utilisateurStages->getStage($stagesIntitule->getIdstage()->getId());
                if ($stage)
                {
                    $stage->addIntitulesActivites($stagesIntitule);
                }
            }
        }
    }

    /**
     * @return array
     */
    public function analyseUtilisateursStages()
    {
        $cptUtilisateurs = 0;
        $cptStages = 0;
        $cptSansStages = 0;
        $cptStagesIncomplets = 0;

        foreach ($this->utilisateurs as $utilisateur)
        {
            $cptUtilisateurs++;

            $nbStage = count($utilisateur->getStages());
            if ($nbStage == 0) {
                $cptSansStages++;
            }
            else
            {
                $cptStagesIncomplets += $utilisateur->countStagesIncomplets();
                $cptStages += $nbStage;
            }
        }

        return array('nbUtilisateurs' => $cptUtilisateurs, 'nbStages' => $cptStages, 'nbUtilisateursSansStage' => $cptSansStages,
            'nbStagesIncomplets' => $cptStagesIncomplets);
    }
}