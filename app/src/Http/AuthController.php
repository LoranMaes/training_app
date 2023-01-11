<?php

use Services\{DatabaseConnector, MailService};

class AuthController
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

    public function logout()
    {
        session_start();
        // Unset all of the session variables.
        $_SESSION = [];
        // If it's desired to kill the session, also delete the session cookie.
        // Note: This will destroy the session, and not just the session data!
        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(
                session_name(),
                '',
                time() - 42000,
                $params["path"],
                $params["domain"],
                $params["secure"],
                $params["httponly"]
            );
        }

        // Finally, destroy the session.
        session_destroy();

        // redirect to index
        header('location: /alela/');
        exit();
    }

    public function showLogin()
    {
        echo $this->twig->render('login.twig', []);
    }

    public function login()
    {
        echo $this->twig->render('login.twig', []);
    }
}
