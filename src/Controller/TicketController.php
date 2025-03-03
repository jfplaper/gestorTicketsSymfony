<?php

namespace App\Controller;

use App\Entity\Ticket;
use App\Form\TicketType;
use App\Repository\MessageRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/ticket')]
final class TicketController extends AbstractController
{
    #[Route('/new', name: 'app_ticket_new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $ticket = new Ticket();
        $form = $this->createForm(TicketType::class, $ticket);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Establezco algunos valores de propiedades yo, no a través del formulario
            $ticket->setState(null);
            $ticket->setScore(null);
            $ticket->setClient($this->getUser());
            $ticket->setWorker(null);

            $entityManager->persist($ticket);
            $entityManager->flush();

            return $this->redirectToRoute('app_main', [], Response::HTTP_SEE_OTHER);
        }

        return $this->render('ticket/new.html.twig', [
            'ticket' => $ticket,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/assign', name: 'app_ticket_assign', methods: ['GET', 'POST'])]
    public function assign(Ticket $ticket, EntityManagerInterface $entityManager): Response
    {
        // Cambio el estado del ticket a abierto
        $ticket->setState("abierto");
        $ticket->setWorker($this->getUser());

        $entityManager->persist($ticket);
        $entityManager->flush();

        return $this->redirectToRoute('app_main', [], Response::HTTP_SEE_OTHER);
    }

    #[Route('/{id}/finish', name: 'app_ticket_finish', methods: ['GET', 'POST'])]
    public function finish(Ticket $ticket, EntityManagerInterface $entityManager): Response
    {
        // Cambio el estado del ticket a finalizado
        $ticket->setState("finalizado");

        $entityManager->persist($ticket);
        $entityManager->flush();

        return $this->redirectToRoute('app_main', [], Response::HTTP_SEE_OTHER);
    }

    #[Route('/score/{id}/{score}', name: 'app_ticket_score', methods: ['GET', 'POST'])]
    public function score(Ticket $ticket, Request $request, EntityManagerInterface $entityManager): Response
    {
        // Por get obtengo el score a asignar (CUIDADO con query->get porque aquí no funciona con query)
        $score = $request->get("score");
        $ticket->setScore($score);

        $entityManager->persist($ticket);
        $entityManager->flush();

        return $this->redirectToRoute('app_main', [], Response::HTTP_SEE_OTHER);
    }

    #[Route('/{id}', name: 'app_ticket_show', methods: ['GET'])]
    public function show(Ticket $ticket, MessageRepository $messageRepository): Response
    {
        $messages = $messageRepository->findBy(['ticket' => $ticket->getId()]);

        return $this->render('ticket/show.html.twig', [
            'ticket' => $ticket,
            'messages' => $messages
        ]);
    }
}
