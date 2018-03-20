<?php
/**
 * Created by PhpStorm.
 * User: epsi
 * Date: 15/03/18
 * Time: 18:03
 */

namespace AppBundle\Validator\Constraints;


use Symfony\Component\Validator\Constraint;


/**
 * @Annotation
 */
class StageDates extends Constraint
{
    public $message = 'La date de début doit être inférieure à la date de fin.';
}