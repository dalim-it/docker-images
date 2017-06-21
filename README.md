# TraefikAcmeToCerts

## Description
A script to create cert and key files from Traefik acme.json

## Usage
``` bash
$ docker run -t --rm -v /path/to/acme.json:/app/acme/acme.json -v /path/to/save/certs:/app/certs farfeduc/traefikacmetocerts
```

## License
MIT