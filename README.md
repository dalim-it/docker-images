# TraefikAcmeToCerts

## Description
A script to create cert and key files from Traefik acme.json

## Usage
``` bash
$ docker run -t --rm -v /path/to/acme.json:/app/acme.json -v /path/to/save/certs:/app/certs sushifu/traefikacmetocerts
```

## License
MIT