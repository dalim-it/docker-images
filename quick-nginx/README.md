Nginx web server with a very basic but yet dynamic configuration.

It can be used to serve static files as well as using a PHP-FPM backend in a
[separate container](https://hub.docker.com/_/php/).

Env. variable | Description
---|---
`SERVER_ROOT` | Server root directory, defaults to `/app`
`SERVER_INDEX` | Server index (only one file), defaults to `index.html`
`PHP_FPM_HOST` | Set the PHP-FPM host to use, it must have port 9000 exposed
`FORCE_PHP_INDEX`| Drops a 404 when requesting other PHP files than your index

__docker-compose.yml example:__

```yaml
version: '3'
services:
  php:
    image: urbit/lumen-php-fpm
    volumes:
      - .:/var/www/application
  nginx:
    image: dalimit/quick-nginx
    environment:
      SERVER_INDEX: public/index.php
      SERVER_ROOT: /var/www/application
      PHP_FPM_HOST: php
      FORCE_PHP_INDEX: "true"
```
