<?php
/**
 * Created by PhpStorm.
 * User: jeanlucbompard
 * Date: 14/02/18
 * Time: 10:28
 */

namespace AppBundle\Redirection;


use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\RouterInterface;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Http\Authentication\AuthenticationSuccessHandlerInterface;

class AfterLoginRedirection implements AuthenticationSuccessHandlerInterface
{
    /**
     * @var \Symfony\Component\Routing\RouterInterface
     */
    private $router;

    /**
     * @param RouterInterface $router
     */
    public function __construct(RouterInterface $router)
    {
        $this->router = $router;
    }

    /**
     * @param Request $request
     * @param TokenInterface $token
     * @return RedirectResponse
     */
    public function onAuthenticationSuccess(Request $request, TokenInterface $token)
    {
        // On récupère la liste des rôles d'un utilisateur
        $roles = $token->getRoles();

        // On extrait la chaine de caractère
        $rolesTab = array_map(function ($role) {
            return $role->getRole();
        }, $roles);


        if (in_array('ROLE_PROF', $rolesTab, true))
        {
            $redirection = new RedirectResponse($this->router->generate('prof_homepage'));
        }
        else
        {
            $redirection = new RedirectResponse($this->router->generate('homepage'));
        }

        return $redirection;
    }
}