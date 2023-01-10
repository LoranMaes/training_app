<?php

namespace Services;

// USE STATEMENTS HERE

use MessageFormatter;
use Symfony\Component\Mailer\Transport;
use Symfony\Component\Mailer\Mailer;
use Symfony\Component\Mime\Email;
use Symfony\Component\EventDispatcher\EventDispatcher;
use Symfony\Component\Mailer\EventListener\MessageListener;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Bridge\Twig\Mime\BodyRenderer;
use \Twig\Environment as TwigEnvironment;

class MailService
{

    static function send($username)
    {
        $loader = new \Twig\Loader\FilesystemLoader(__DIR__ . '/../../resources/templates/alela');
        $twig = new TwigEnvironment($loader);
        $messageListener = new MessageListener(null, new BodyRenderer($twig));

        $eventDispatcher = new EventDispatcher();
        $eventDispatcher->addSubscriber($messageListener);

        $transport = Transport::fromDsn('smtp://' . $_ENV["MAIL_USERNAME"] . ':' . $_ENV["MAIL_PASSWORD"] . '@' . $_ENV["MAIL_HOST"] . ':' . MAIL_PORT, $eventDispatcher);
        $mailer = new Mailer($transport, null, $eventDispatcher);

        $email = (new TemplatedEmail())
            ->from('hello@example.com')
            ->to('loran.maes@gmail.com')
            //->cc('cc@example.com')
            //->bcc('bcc@example.com')
            //->replyTo('fabien@example.com')
            //->priority(Email::PRIORITY_HIGH)
            ->subject('Account succesfully created!')
            ->htmlTemplate('/emailtemplate.twig')
            ->context([
                'name' => $username,
            ]);

        $mailer->send($email);
    }
}
