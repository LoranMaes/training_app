<?php

use Services\{DatabaseConnector, MailService};

class AuthController
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
        echo $this->twig->render('auth/login.twig', []);
    }

    public function login()
    {
        $mail = isset($_POST['email']) ? $_POST['email'] : '';
        $password = isset($_POST['password']) ? $_POST['password'] : '';

        $formErrors = array(
            'mail' => false,
            'password' => false,
        );

        if (trim($mail) === '') {
            $formErrors['mail'] = true;
        }
        if (trim($password) === '') {
            $formErrors['password'] = true;
        }

        if (!in_array(true, $formErrors)) {
            $user = $this->connection->fetchAssociative('SELECT * FROM users INNER JOIN athletes ON athletes.users_id = users.id WHERE users.mail = ?', [$mail]);
            if ($user !== false && password_verify($password, $user['password'])) {
                $_SESSION['athlete'] = $user;
                // Expire 31 days after last login.
                setcookie('lastLoginName', $user['username'], time() + 60 * 60 * 24 * 31);
                $dateTime = new DateTime();
                setcookie('lastLoginTime', $dateTime->format('d/m/Y H:i'), time() + 60 * 60 * 24 * 31);
                header('Location: /');
                exit();
            } else {
                $formErrors['password'] = true;
            }
        }

        echo $this->twig->render('auth/login.twig', [
            'errors' => $formErrors,
            'email' => $mail
        ]);
    }

    public function showRegister()
    {
        echo $this->twig->render('auth/register.twig', []);
    }

    public function register()
    {
        echo $this->twig->render('auth/register.twig', []);
    }
}
