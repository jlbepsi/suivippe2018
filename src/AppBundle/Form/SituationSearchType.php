<?php
/**
 * Created by PhpStorm.
 * User: jeanluc.bompard
 * Date: 02/02/2017
 * Time: 14:05
 */

namespace AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class SituationSearchType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        // Ajout des champs "classiques"
        $builder
            ->add('libelle', 'Symfony\Component\Form\Extension\Core\Type\TextType', array('label' => 'Libelle : ', 'required' => false))
            ->add('descriptif', 'Symfony\Component\Form\Extension\Core\Type\TextType', array('label' => 'Descriptif : ', 'required' => false))
            //->add('date', 'text', array('label' => 'Date de stage : ', 'required' => false));
            ->add('date', DateType::class, array('widget' => 'single_text', 'label' => 'Date incluse : ',
                  'required' => false, 'html5' => false, 'format' => 'dd/MM/yyyy'));
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'AppBundle\Form\SituationSearchCriteria'
        ));
    }

    /**
     * {@inheritdoc}
     */
    public function getBlockPrefix()
    {
        return 'appbundle_SituationSearchCriteria';
    }
}