<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Situationtypo
 *
 * @ORM\Table(name="situationtypo", indexes={@ORM\Index(name="reference", columns={"reference"}), @ORM\Index(name="code", columns={"code"})})
 * @ORM\Entity
 */
class Situationtypo
{
    /**
     * @var integer
     *
     * @ORM\Column(name="reference", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="NONE")
     */
    private $reference;

    /**
     * @var integer
     *
     * @ORM\Column(name="code", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="NONE")
     */
    private $code;


}
