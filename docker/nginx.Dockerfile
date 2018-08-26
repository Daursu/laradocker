FROM nginx:1.15-alpine

WORKDIR /app/public

COPY nginx.conf /etc/nginx/nginx.conf
