FROM nginx:1.21.6

ENV NGINX_HTTP_PORT=8080
ENV NGINX_HTTPS_PORT=4433

EXPOSE ${NGINX_HTTPS_PORT}

COPY ./default.conf.template /etc/nginx/templates/default.conf.template
COPY ./nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
COPY ./nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key