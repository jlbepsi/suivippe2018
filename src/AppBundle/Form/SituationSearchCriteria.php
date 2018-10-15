<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 02/02/2017
 * Time: 14:43
 */

namespace AppBundle\Form;


class SituationSearchCriteria
{
    public $libelle;
    public $descriptif;
    public $date;

    public function isEmpty()
    {
        return empty($this->libelle)
            && empty($this->descriptif)
            && empty($this->date);
    }
}