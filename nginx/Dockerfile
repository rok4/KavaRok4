FROM nginx
MAINTAINER thibault.coupin gmail

ADD ./leaflet/* /usr/share/nginx/html/

ADD ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

CMD /docker-entrypoint.sh
