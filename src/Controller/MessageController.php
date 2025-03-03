<?php

namespace App\Controller;

use App\Entity\Message;
use App\Entity\Ticket;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class MessageController extends AbstractController
{
    #[Route('/{id}/message/create', name: 'app_message_create', methods: ['GET', 'POST'])]
    public function createMessage(Ticket $ticket, Request $request, EntityManagerInterface $entityManager): Response
    {
        // Guardamos el texto del input en una variable
        $response = $request->query->get('response');

        if (isset($response) && $response != "") {
            $message = new Message();
            $message->setAuthor($this->getUser());
            $message->setTicket($ticket);
            $message->setText($response);

            $entityManager->persist($message);
            $entityManager->flush();

            // En la redirección de ruta paso como parámetro el id del ticket
            return $this->redirectToRoute('app_ticket_show', ['id'=> $ticket->getId()], Response::HTTP_SEE_OTHER);
        }

        return $this->redirectToRoute('app_main', [], Response::HTTP_SEE_OTHER);
    }
}
