# localhost-dot-run
Simplified image for creating ssh tunnels with localhost.run

## Overview

Simplified version of [jnovack/docker-autossh](https://github.com/jnovack/docker-autossh) for use with https://localhost.run/ in docker-based developer environments.

## Examples

### docker run

```
#!/bin/bash

docker run --rm -ti \
  -e SSH_HOSTUSER=${USER} \
  -e SSH_TUNNEL_HOST=localhost \
  -e SSH_TUNNEL_LOCAL=80 \
  avinson/localhost-dot-run
  ```

### docker-compose

```
version: "3.4"
volumes:
  ssh-data:
    driver: local

services:
  nginx:
    image: nginxdemos/hello
    depends_on:
      - "webhook"

  webhook:
    image: avinson/localhost-dot-run
    restart: unless-stopped
    stdin_open: true
    tty: true
    environment:
      - SSH_HOSTUSER=${USER}
      - SSH_TUNNEL_HOST=nginx
      - SSH_TUNNEL_LOCAL=80
    volumes:
      - ssh-data:/root/.ssh
```
