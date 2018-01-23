<?php

namespace AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class SituationType extends AbstractType
{
    /**
     * {@inheritdoc}
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('libelle')
            ->add('descriptif')
            ->add('datedebut')
            ->add('datefin');

        // Ajout des champs liés à une table
        $builder->add('codelangage', 'Symfony\Bridge\Doctrine\Form\Type\EntityType', array(
            'class' => 'AppBundle:Langage',
            'required' =>true,
            'label' => "Langage:",
            'choice_label' => 'libelle',
        ));

        $builder->add('codeframework', 'Symfony\Bridge\Doctrine\Form\Type\EntityType', array(
            'class' => 'AppBundle:Framework',
            'required' =>true,
            'label' => "Framework:",
            'choice_label' => 'libelle',
        ));

        $builder->add('codeos', 'Symfony\Bridge\Doctrine\Form\Type\EntityType', array(
            'class' => 'AppBundle:Operatingsystem',
            'required' =>true,
            'label' => "Système d'exploitation:",
            'choice_label' => 'libelle',
        ));


        $builder->add('codeservice', 'Symfony\Bridge\Doctrine\Form\Type\EntityType', array(
            'class' => 'AppBundle:Services',
            'required' =>true,
            'label' => "Service:",
            'choice_label' => 'libelle',
        ));
    }
    
    /**
     * {@inheritdoc}
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'AppBundle\Entity\Situation'
        ));
    }

    /**
     * {@inheritdoc}
     */
    public function getBlockPrefix()
    {
        return 'appbundle_situation';
    }


}
