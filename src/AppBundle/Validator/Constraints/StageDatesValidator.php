<?php
/**
 * Created by PhpStorm.
 * User: epsi
 * Date: 15/03/18
 * Time: 18:05
 */

namespace AppBundle\Validator\Constraints;


use Symfony\Component\Validator\Constraint;
use Symfony\Component\Validator\ConstraintValidator;


/**
 * @Annotation
 */
class StageDatesValidator extends ConstraintValidator
{
    public function validate($value, Constraint $constraint)
    {
        // Obtention de l'entité
        $entity = $this->context->getObject();

        if ($entity->getDatedebut() > $entity->getDatefin())
        {
            $this->context->buildViolation($constraint->message)
                ->addViolation();
        }
    }

}