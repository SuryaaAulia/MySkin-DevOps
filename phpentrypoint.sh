#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    cp .env.example .env
fi

if ! php artisan tinker --execute="DB::table('users')->exists() || DB::table('doctors')->exists();" > /dev/null 2>&1; then
    echo "Database is empty, seeding..."
    sleep 10 && php artisan migrate
    sleep 10 && php artisan db:seed --class=DatabaseSeeder
else
    echo "Database is already seeded dawgg."
fi

php artisan serve --port=8000 --host=0.0.0.0 --env=.env
exec docker-php-entrypoint "$@"
