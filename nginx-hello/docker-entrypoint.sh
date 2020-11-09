#!/bin/sh

if [ -n "$WAIT_FOR_WEBHOOK" ]; then
  until docker logs ${WEBHOOK_CONTAINER_NAME} | grep -q 'tunneled with tls termination' ; do
    >&2 echo "webhook unavailable - sleeping"
    sleep 1
  done
  export WEBHOOK_URI=https://$(docker logs ${WEBHOOK_CONTAINER_NAME} | grep 'tunneled with tls termination' | grep -Po "${SSH_HOSTUSER}.*\.run" | tr -d '[:cntrl:]')
  echo "WEBHOOK_URI is ${WEBHOOK_URI}"
fi

dockerize -template /etc/nginx/conf.d/hello-plain-text.conf.tmpl:/etc/nginx/conf.d/hello-plain-text.conf
echo "executing $@"
exec "$@"
