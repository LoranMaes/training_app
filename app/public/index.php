<?php

require_once('../vendor/autoload.php');

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/..');
$dotenv->load();

$router = new \Bramus\Router\Router();

$router->before('GET|POST', '/.*', function () {
    session_start();
});

// To logout a user
$router->before('GET|POST', '/logout', function () {
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
    header('location: /');
    exit();
});

// For the users main content
$router->before('GET|POST', '/', function () {
    if (!isset($_SESSION['athlete'])) {
        header('Location: /login');
        exit;
    }
});
$router->get('/', 'DashboardController@showDashboard');

// Login for users
$router->before('GET|POST', '/login', function () {
    if (isset($_SESSION['athlete'])) {
        header('Location: /');
        exit;
    }
});
$router->get('/login', 'AuthController@showLogin');
$router->post('/login', 'AuthController@login');

// For people who register
$router->get('/register', 'AuthController@showRegister');
$router->post('/register', 'AuthController@register');

// TODO - Routes for registering and logging in as trainer.

$router->run();
