#!/bin/sh
cd /etc/nginx

CONF=conf.d/default.conf
PHP_LOC=conf.parts/php_loc.conf
PHP_SOFT=conf.parts/php_soft.conf
PHP_STRICT=conf.parts/php_strict.conf

sed -i "s@__SERVER_ROOT__@${SERVER_ROOT}@g" ${CONF}
sed -i "s@__SERVER_INDEX__@${SERVER_INDEX}@g" ${CONF}

if [[ ! -z ${PHP_FPM_HOST} ]]; then
    sed -i "s/__PHP_FPM_HOST__/${PHP_FPM_HOST}/g" ${PHP_LOC}

    if [[ ${FORCE_PHP_INDEX} = "true" ]]; then
        ESACPED_SERVER_INDEX=$(echo "${SERVER_INDEX}" | sed -r 's@\.@\\\\.@g')
        sed -i "s@__ESCAPED_SERVER_INDEX__@${ESACPED_SERVER_INDEX}@g" ${PHP_STRICT}
        sed -i "s@__PHP_LOCATION__@include ${PHP_STRICT};@g" ${CONF}
    else
        sed -i "s@__PHP_LOCATION__@include ${PHP_SOFT};@g" ${CONF}
    fi
else
    sed -i "s@__PHP_LOCATION__@@g" ${CONF}
fi

echo ${CONF} && cat ${CONF}
echo ${PHP_LOC} && cat ${PHP_LOC}
echo ${PHP_SOFT} && cat ${PHP_SOFT}
echo ${PHP_STRICT} && cat ${PHP_STRICT}

nginx -g "daemon off;";
