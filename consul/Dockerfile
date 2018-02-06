FROM consul:1.0.3

COPY pre-entrypoint.sh /bin/pre-entrypoint.sh

ENV CONSUL_WEAVE_IP=

ENTRYPOINT ["/bin/pre-entrypoint.sh"]
