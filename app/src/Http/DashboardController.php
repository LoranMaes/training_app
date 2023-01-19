<?php

use Services\{DatabaseConnector, MailService, Calendar};

class DashboardController
{
    protected \Twig\Environment $twig;
    protected \Doctrine\DBAL\Connection $connection;

    public function __construct()
    {
        $this->connection = DatabaseConnector::getConnection('astride');

        // bootstrap Twig
        $loader = new \Twig\Loader\FilesystemLoader(__DIR__ . '/../../resources/templates');
        $this->twig = new \Twig\Environment($loader);
        $function = new \Twig\TwigFunction('url', function ($path) {
            return $_ENV["BASE_PATH"] . $path;
        });
        $this->twig->addFunction($function);
    }

    public function showDashboard()
    {
        $user = $_SESSION['athlete'];

        echo $this->twig->render('athlete/dashboard.twig', [
            'calendar' => new \Calendar('2021-02-02'),
            'athlete' => true,
            'user' => $user,
        ]);
    }
}
