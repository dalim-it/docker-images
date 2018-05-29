FROM nginx:alpine

ENV SERVER_ROOT="/app" \
    SERVER_INDEX="index.html" \
    FORCE_PHP_INDEX="false"

COPY default.conf /etc/nginx/conf.d/default.conf
COPY conf.parts /etc/nginx/conf.parts

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
