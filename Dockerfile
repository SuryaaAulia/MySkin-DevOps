FROM php:8.2 AS php

RUN apt-get update -y && \
    apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    libbz2-dev \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libicu-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    gcc \
    make \
    autoconf \
    pkg-config && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install \
    bz2 \
    gd \
    intl \
    mysqli \
    pdo_mysql

RUN pecl install -o -f redis \
    && rm -rf /temp/pear \
    && docker-php-ext-enable redis

WORKDIR /var/www
COPY . .
COPY --from=composer:2.6.5 /usr/bin/composer /usr/bin/composer

ENV PORT=8000

RUN composer install --no-progress --no-interaction && \
    php artisan migrate:fresh && \
    php artisan db:seed --class="database\seeders\DatabaseSeeder" && \
    php artisan key:generate

CMD ["php", "artisan", "serve", "--port=8000", "--host=0.0.0.0", "--env=.env"]
