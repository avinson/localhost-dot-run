#!/bin/sh

if [ -n "$WAIT_FOR_WEBHOOK" ]; then
  until docker logs ${WEBHOOK_CONTAINER_NAME} | grep -q 'Connect to .*localhost.run' ; do
    >&2 echo "webhook unavailable - sleeping"
    sleep 1
  done
  export WEBHOOK_URI=$(docker logs ${WEBHOOK_CONTAINER_NAME} | tr -d '[:cntrl:]' | grep 'Connect to .*localhost.run' | grep -Po 'https://.*\.run$')
fi

dockerize -template /etc/nginx/conf.d/hello-plain-text.conf.tmpl:/etc/nginx/conf.d/hello-plain-text.conf
echo "executing $@"
exec "$@"
