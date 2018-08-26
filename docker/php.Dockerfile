# ----------------------
# Composer install step
# ----------------------
FROM composer:1.7 as build

WORKDIR /app

COPY composer.json composer.json
COPY composer.lock composer.lock
COPY database/ database/

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

# ----------------------
# The FPM container
# ----------------------
FROM php:7.2-fpm

RUN docker-php-ext-install -j$(nproc) pdo_mysql

WORKDIR /app
VOLUME /app/storage

COPY ./docker/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY . /app
COPY --from=build /app/vendor/ /app/vendor/
