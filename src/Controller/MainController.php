<?php

namespace App\Controller;

use App\Repository\TicketRepository;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class MainController extends AbstractController
{
    #[Route('/', name: 'app_main')]
    public function index(TicketRepository $ticketRepository, UserRepository $userRepository): Response
    {
        $tickets = null;
        $newTickets = null;
        $users = null;

        if ($this->getUser()) {
            if (in_array("ROLE_ADMIN", $this->getUser()->getRoles())) {
                // Obtengo todos los tickets existentes para que el admin los pueda ver
                $tickets = $ticketRepository->findAll();
                $users = $userRepository->findAll();
            } elseif (in_array("ROLE_WORKER", $this->getUser()->getRoles())) {
                // Obtengo los tickets no finalizados y atendidos/respondidos por el trabajador
                $tickets = $ticketRepository->findBy(['worker' => $this->getUser(), 'state' => 'abierto']);
                // Obtengo todos los tickets nuevos sin trabajadores que los atiendan
                $newTickets = $ticketRepository->findBy(['state' => null]);
            } else {
                // Obtengo los tickets del usuario
                $tickets = $ticketRepository->findBy(['client' => $this->getUser()]);
            }
        }

        return $this->render('main/index.html.twig', [
            'tickets' => $tickets,
            'newTickets' => $newTickets,
            'users' => $users
        ]);
    }
}
