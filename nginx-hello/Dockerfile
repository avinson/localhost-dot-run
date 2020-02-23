FROM nginx:1.17-alpine

ENV DOCKERIZE_VERSION 0.6.1
ENV DOCKERIZE_URL https://github.com/jwilder/dockerize/releases/download/v${DOCKERIZE_VERSION}/dockerize-linux-amd64-v${DOCKERIZE_VERSION}.tar.gz
ENV DOCKERIZE_SHA256 4b0cb92669b74312047c83fb7dd26a95115abfa6e21c7eb102e8206a437eb531

RUN apk --no-cache add \
  curl \
  docker-cli \
  grep

# install dockerize
RUN curl -fsSL -o /tmp/dockerize.tgz $DOCKERIZE_URL \
  && cd /usr/local/bin && tar xzf /tmp/dockerize.tgz \
  && echo "$DOCKERIZE_SHA256  /usr/local/bin/dockerize" | sha256sum -c -

RUN rm /etc/nginx/conf.d/*
ADD hello-plain-text.conf.tmpl /etc/nginx/conf.d/

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
