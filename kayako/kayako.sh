#!/bin/sh

set_config() {
    key="$1"
    value="$2"
    sed -i "s/'$key'\s*,\s*'.*'/'$key', '$value'/" __swift/config/config.php
}

set_config 'SWIFT_BASENAME' "$KAYAKO_BASENAME"
set_config 'DB_HOSTNAME' "$KAYAKO_DB_HOSTNAME"
set_config 'DB_USERNAME' "$KAYAKO_DB_USERNAME"
set_config 'DB_PASSWORD' "$KAYAKO_DB_PASSWORD"
set_config 'DB_NAME' "$KAYAKO_DB_NAME"
set_config 'DB_PORT' "$KAYAKO_DB_PORT"

chown -R www-data /srv/web
chmod 777 /srv/web/__swift/files /srv/web/__swift/cache /srv/web/__swift/geoip /srv/web/__swift/logs /srv/web/__apps
chmod 755 /srv/web/console/index.php

if [[ $RELAY_HOST != '' ]]; then
    postconf -e relayhost=$RELAY_HOST
fi

if [[ $ALWAYS_BCC != '' ]]; then
    postconf -e always_bcc=$ALWAYS_BCC
fi

if [[ $HEADER_CHECKS != '' ]]; then
    postconf -e header_checks=$HEADER_CHECKS
fi

if [[ $MSG_SIZE_LIMIT != '' ]]; then
    postconf -e message_size_limit=$MSG_SIZE_LIMIT
fi

if [[ $POSTFIX_ENABLE != 'false' ]]; then
    # Disable SMTPUTF8, because libraries (ICU) are missing in alpine
    postconf -e smtputf8_enable=no
    postfix start
fi

nginx && php-fpm
