#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    cp .env.example .env
fi

php artisan:key generate
php artisan migrate
php artisan db:seed --class=DatabaseSeeder

php artisan serve --port=8000 --host=0.0.0.0 --env=.env

exec docker-php-entrypoint "$@"

