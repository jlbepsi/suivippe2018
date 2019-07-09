<?php


namespace AppBundle\Manager;


use AppBundle\Entity\UserLdap;
use Symfony\Component\DependencyInjection\Container;

class UserLdapManager
{

    public static function getUserFromEntry($username, $entry)
    {
        return new UserLdap($username, $entry);
    }

}