<?php


namespace AppBundle\Controller\Prof;


use AppBundle\Manager\SituationManager;
use AppBundle\Manager\StageManager;
use AppBundle\Manager\SyntheseBuilder;
use AppBundle\Manager\SyntheseManager;
use AppBundle\Manager\SynthesePDF;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ProfSyntheseController extends Controller
{
    private function getManager()
    {
        return new SyntheseManager($this->get('doctrine')->getManager());
    }
    private function getSyntheseManager()
    {
        return new SyntheseManager($this->get('doctrine')->getManager());
    }
    private function getSituationManager()
    {
        return new SituationManager($this->get('doctrine')->getManager());
    }
    private function getStageManager()
    {
        return new StageManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/prof/synthese", name="prof_synthese_index")
     */
    public function syntheseAction(Request $request)
    {
        $classe = "B2";
        // Obtention du service Ldap
        $serviceLdap = $this->get('security.user.provider.concrete.ldap_provider');
        // Obtention du manager puis des situations
        $utilisateurs = $this->getManager()->loadUtilisateursSyntheses($serviceLdap, $classe);

        return $this->render('prof/synthese/index.html.twig',
            array('utilisateurs' => $utilisateurs, 'classe' => $classe));
    }

    /**
     * @Route("/prof/synthese/tableau/{login}", name="prof_synthese_tableau")
     * @param Request $request
     * @param $login
     * @return Response|null
     */
    public function tableauAction(Request $request, $login)
    {
        // Obtention de l'utilisateur Ldap
        $serviceLdap = $this->get('security.user.provider.concrete.ldap_provider');
        if (! $userLdap = $serviceLdap->loadUserLdapByLogin($login))
        {
            return $this->render("Exception/error404.html.twig");
        }

        return $this->generatePDF($userLdap);
    }

    private function generatePDF($user)
    {
        /*
         * LES DONNEES
         */
        // Obtention du parcours
        $idParcours = $user->getNumparcours();
        // Obtention de toutes les activités
        $activitesDomaine = $this->getSyntheseManager()->loadActivitesDomaine($idParcours);

        // L'objet qui conteindra toutes les informations pré-formatées
        $syntheseBuilder = new SyntheseBuilder();
        // L'utilisateur
        $syntheseBuilder->setUtilisateur($user);
        // Obtention des activités et domaines
        $syntheseBuilder->addActivitesDomaine($activitesDomaine);
        // Obtention des typologies
        $typologies = $this->getSyntheseManager()->loadTypologies();
        $syntheseBuilder->addTypologies($typologies);
        // Obtention des situations
        $situations = $this->getSituationManager()->loadSituations($user->getUsername());
        $syntheseBuilder->addSituations($situations);

        // Obtention des stages
        $stages = $this->getStageManager()->loadStageIntitulesUser($user->getUsername());
        $syntheseBuilder->addStagesIntitules($stages);


        /*
         * LA GENERATION DU PDF
         */
        $synthesePdf = new SynthesePdf($syntheseBuilder);

        return new Response($synthesePdf->generateSynthese(), 200, array('Content-Type' => 'application/pdf'));
    }
}