FROM alpine:latest

ENV TZ=Europe/Kiev

RUN apk update; \
    apk add --no-cache apache2 apache2-ctl php tzdata; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;\
    echo $TZ > /etc/timezone; \
    apk del tzdata
RUN rm -rf /var/www/html/index.html

COPY src/index.php /var/www/html

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
