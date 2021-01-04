FROM ubuntu:trusty

RUN apt-get update && apt-get install -y nginx nginx-extras apache2-utils

EXPOSE 80/tcp
COPY webdav.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/* && chown -R www-data:www-data /media
CMD nginx -g "daemon off;"
