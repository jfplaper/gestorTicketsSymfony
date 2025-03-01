<?php

namespace App\Controller;

use App\Repository\TicketRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class MainController extends AbstractController
{
    #[Route('/', name: 'app_main')]
    public function index(TicketRepository $ticketRepository): Response
    {
        $tickets = null;
        
        // Obtengo los tickets del usuario
        $tickets = $ticketRepository->findBy(['client' => $this->getUser()]);

        return $this->render('main/index.html.twig', [
            'tickets' => $tickets,
        ]);
    }
}
