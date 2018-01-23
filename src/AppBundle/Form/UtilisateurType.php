<?php

namespace AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class UtilisateurType extends AbstractType
{
    /**
     * {@inheritdoc}
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('classe', 'Symfony\Component\Form\Extension\Core\Type\TextType', array('label' => 'Libellé court: '))
            ->add('nom', 'Symfony\Component\Form\Extension\Core\Type\TextType', array('label' => 'Libellé court: '))
            ->add('prenom', 'Symfony\Component\Form\Extension\Core\Type\TextType', array('label' => 'Libellé court: '))
            ->add('mail', 'Symfony\Component\Form\Extension\Core\Type\TextType', array('label' => 'Libellé court: '))
            ->add('sexe', 'Symfony\Component\Form\Extension\Core\Type\IntegerType', array('label' => 'Sexe: '))
            ->add('datenaissance', 'Symfony\Component\Form\Extension\Core\Type\DateTimeType', array('label' => 'Date de naissance: '))
            ->add('adresse', 'Symfony\Component\Form\Extension\Core\Type\TextareaType', array('label' => 'Adresse complète : '))
        ;

        // Ajout des champs liés à une table
        $builder->add('numparcours', 'Symfony\Bridge\Doctrine\Form\Type\EntityType', array(
            'class' => 'AppBundle:Parcours',
            'required' =>true,
            'label' => "Parcours",
            'choice_label' => 'libelle',
        ));
    }
    
    /**
     * {@inheritdoc}
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'AppBundle\Entity\Utilisateur'
        ));
    }

    /**
     * {@inheritdoc}
     */
    public function getBlockPrefix()
    {
        return 'appbundle_utilisateur';
    }


}
