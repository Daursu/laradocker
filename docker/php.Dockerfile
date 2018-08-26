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
# yarn install step
# ----------------------
FROM node:8-alpine as node

WORKDIR /app

COPY *.json *.yarn *.mix.js /app/
COPY resources/assets/ /app/resources/assets/

RUN mkdir -p /app/public \
    && yarn install && yarn run production

# ----------------------
# The FPM container
# ----------------------
FROM php:7.2-fpm

RUN docker-php-ext-install -j$(nproc) pdo_mysql

WORKDIR /app

COPY ./docker/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY . /app
COPY --from=build /app/vendor/ /app/vendor/
COPY --from=node /app/public/js/ /app/public/js/
COPY --from=node /app/public/css/ /app/public/css/
COPY --from=node /app/mix-manifest.json /app/public/mix-manifest.json

VOLUME /app
