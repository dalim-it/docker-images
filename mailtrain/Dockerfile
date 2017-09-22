FROM node:8-alpine

MAINTAINER mekwinkfr <melwinkieffer@gmail.com>

RUN set -e && apk add --no-cache curl \
    && curl -L https://github.com/Mailtrain-org/mailtrain/archive/master.zip -o /tmp/mt.zip \
    && unzip /tmp/mt.zip \
    && mv mailtrain-master /app \
    && cd /app \
    && npm install --production && npm install passport-ldapjs

ENV NODE_ENV=production

EXPOSE 3000

WORKDIR /app

ENTRYPOINT ["sh", "/app/docker-entrypoint.sh"]

CMD ["node", "index.js"]
