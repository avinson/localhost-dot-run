FROM alpine:3

ENV SSH_HOSTNAME ssh.localhost.run
ENV SSH_TUNNEL_REMOTE 80

RUN apk --no-cache add \
  autossh \
  dumb-init

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

ADD docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]