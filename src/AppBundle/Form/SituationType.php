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
            ->add('libelle', 'Symfony\Component\Form\Extension\Core\Type\TextType')
            ->add('descriptif', 'Symfony\Component\Form\Extension\Core\Type\TextareaType')
            ->add('datedebut', 'Symfony\Component\Form\Extension\Core\Type\DateType', array('widget' => 'single_text', 'format' => 'dd/MM/yyyy'))
            ->add('datefin', 'Symfony\Component\Form\Extension\Core\Type\DateType', array('widget' => 'single_text', 'format' => 'dd/MM/yyyy'));

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
        $builder
            ->add('services', 'Symfony\Component\Form\Extension\Core\Type\TextareaType', array('required' => false));
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
