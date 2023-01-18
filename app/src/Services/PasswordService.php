<?php

class PasswordService
{

    public static function checkPassword(string $password)
    {
        $passwordRegex = "/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/";
        return preg_match($passwordRegex, $password);
    }
}
