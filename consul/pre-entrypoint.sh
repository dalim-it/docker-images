#!/usr/bin/env sh

if [ -z "$CONSUL_WEAVE_IP" ]; 
then
	CONSUL_WEAVE_IP=$( ifconfig ethwe | grep 'inet addr' | cut -d: -f2 | awk '{print $1}' )
fi

docker-entrypoint.sh agent -server -bootstrap -bind=$CONSUL_WEAVE_IP -client=$CONSUL_WEAVE_IP $@ &
child=$!

trap "kill $child" SIGTERM SIGINT
wait "$child"
