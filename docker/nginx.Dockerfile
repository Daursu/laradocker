FROM nginx:1.15-alpine

WORKDIR /app/public

COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./public /app/public
