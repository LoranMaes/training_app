<?php

require_once('../vendor/autoload.php');

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/..');
$dotenv->load();

$router = new \Bramus\Router\Router();

$router->before('GET|POST', '/.*', function () {
    session_start();
});

// add your routes and run!
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
