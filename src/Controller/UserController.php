<?php

namespace App\Controller;

use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/user')]
final class UserController extends AbstractController
{
    #[Route('/change/rol/{id}/{role}', name: 'app_user_change_rol', methods: ['GET', 'POST'])]
    public function changeRol(User $user, Request $request, EntityManagerInterface $entityManager): Response
    {
        // Por get obtengo el rol a asignar (CUIDADO con query->get porque aquí no funciona con query)
        $role = array($request->get("role"));
        $user->setRoles($role);

        $entityManager->persist($user);
        $entityManager->flush();

        return $this->redirectToRoute('app_main', [], Response::HTTP_SEE_OTHER);
    }
}
