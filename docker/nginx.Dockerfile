FROM nginx:1.19-alpine

WORKDIR /app/public

COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./public/* /app/public/
COPY ./docker/resolve-localdomain.sh /docker-entrypoint.d/30-resolve-localdomain.sh

RUN chmod +x /docker-entrypoint.d/30-resolve-localdomain.sh
