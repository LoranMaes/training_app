<?php

require_once('../vendor/autoload.php');

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/..');
$dotenv->load();

$router = new \Bramus\Router\Router();

$router->before('GET|POST', '/.*', function () {
    session_start();
});

// add your routes and run!
$router->get('/', 'DashboardController@showDashboard');

// Login for users
$router->get('/login', 'AuthController@showLogin');
$router->post('/login', 'AuthController@login');

$router->run();
