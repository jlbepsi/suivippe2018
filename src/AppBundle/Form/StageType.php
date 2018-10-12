<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 06/02/2017
 * Time: 14:15
 */

namespace AppBundle\Form;


use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class StageType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        // Ajout des champs "classiques"
        $builder
            ->add('annee', 'Symfony\Component\Form\Extension\Core\Type\NumberType', array('label' => 'Année: '));

        $builder->add('libelleCourt', 'Symfony\Component\Form\Extension\Core\Type\TextType', array('label' => 'Libellé court: '));
        $builder->add('datedebut', 'Symfony\Component\Form\Extension\Core\Type\DateType',
            array('widget' => 'single_text', 'format' => 'dd/MM/yyyy', 'error_bubbling' => true));
        $builder->add('datefin', 'Symfony\Component\Form\Extension\Core\Type\DateType',
            array('widget' => 'single_text', 'format' => 'dd/MM/yyyy', 'error_bubbling' => true));
        $builder->add('descriptif', 'Symfony\Component\Form\Extension\Core\Type\TextareaType', array('label' => 'Descriptif: '));
        $builder->add('entrepriseNom', 'Symfony\Component\Form\Extension\Core\Type\TextareaType', array('label' => 'Nom de l\'entreprise: '));
        $builder->add('entrepriseAdresse', 'Symfony\Component\Form\Extension\Core\Type\TextareaType', array('label' => 'Adresse de l\'entreprise: '));
        $builder->add('entrepriseContact', 'Symfony\Component\Form\Extension\Core\Type\TextareaType', array('label' => 'Contact de l\'entreprise: '));
        $builder->add('entrepriseLogo', FileType::class, array('label' => 'Logo de l\'entreprise: ', 'data_class' => null));
        $builder->add('montant', 'Symfony\Component\Form\Extension\Core\Type\MoneyType', array('label' => 'Montant: '));
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'AppBundle\Entity\Stage'
        ));
    }

    /**
     * {@inheritdoc}
     */
    public function getBlockPrefix()
    {
        return 'appbundle_stage';
    }

}