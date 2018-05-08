FROM php:5.6-fpm-alpine

COPY fpm.conf /usr/local/etc/php-fpm.d/z-custom.conf
COPY php.ini /usr/local/etc/php/php.ini
COPY nginx /etc/nginx

RUN apk add --no-cache libxml2-dev libmcrypt-dev libpng-dev freetype-dev curl-dev openldap-dev imap-dev libssl1.0 php5-opcache php5-mysqli php5-pdo_mysql postfix nginx \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \
    && docker-php-ext-configure imap --with-imap-ssl \
    && docker-php-ext-configure mysql --with-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install mysqli mbstring mcrypt curl gd pdo pdo_mysql xml simplexml json imap sockets dom ldap opcache \
    && ln -s /dev/stdout /var/log/nginx/access.log \
    && ln -s /dev/stderr /var/log/nginx/error.log

VOLUME ["/srv/web/__swift/logs", "/srv/web/__swift/files", "/srv/web/__swift/geoip"]

WORKDIR /srv/web

COPY kayako.sh /usr/local/bin

ENV KAYAKO_BASENAME='index.php?' \
    KAYAKO_DB_HOSTNAME='mysql_host' \
    KAYAKO_DB_USERNAME='mysql_user' \
    KAYAKO_DB_PASSWORD='mysql_pwd' \
    KAYAKO_DB_NAME='kayako_db' \
    KAYAKO_DB_PORT='3306' \
    POSTFIX_ENABLE='true' \
    SMTP_AUTH_MECHANISM_FILTER='plain,login' \
    SMTP_AUTH_SECURITY_OPTIONS='noanonymous'


EXPOSE 80 443

ENTRYPOINT ["kayako.sh"]
