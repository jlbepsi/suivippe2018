<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;

use AppBundle\Entity\Competence;
use AppBundle\Manager\CompetenceManager;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class CompetenceController extends Controller
{
    private function getManager()
    {
        return new CompetenceManager($this->get('doctrine')->getManager());
    }

    /**
     * @Route("/competence/list/{id}", name="competence_list")
     */
    public function listAction($id)
    {
        // Obtention des competences
        $competences = $this->getManager()->loadCompetences($id);

        /*$competencesJSON = array();
        foreach($competences as $item) {
            $competencesJSON[] = array(
                'id' => $item->id(),
                // ... Same for each property you want
            );
        }*/

        return new JsonResponse(array('liste' => $competences));
    }
}
