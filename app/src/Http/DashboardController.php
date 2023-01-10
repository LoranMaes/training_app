<?php

namespace Controllers;

use Services\{DatabaseConnector, MailService};

class DashboardController
{
    protected \Twig\Environment $twig;
    protected \Doctrine\DBAL\Connection $connection;

    public function __construct()
    {
        $this->connection = DatabaseConnector::getConnection('helpdesk');

        // bootstrap Twig
        $loader = new \Twig\Loader\FilesystemLoader(__DIR__ . '/../../resources/templates');
        $this->twig = new \Twig\Environment($loader);
        $function = new \Twig\TwigFunction('url', function ($path) {
            return $_ENV["BASE_PATH"] . $path;
        });
        $this->twig->addFunction($function);
    }
}
