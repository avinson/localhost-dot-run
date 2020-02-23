## Overview

Simplified version of [jnovack/docker-autossh](https://github.com/jnovack/docker-autossh) for use with https://localhost.run/ in docker-based developer environments.

## Examples

Run `docker-compose up` and go to `http://localhost:8080/` for a demo of how to use this image with your service.

### docker run

```
#!/bin/bash

docker run --rm -ti \
  -e SSH_HOSTUSER=${USER} \
  -e SSH_TUNNEL_HOST=localhost \
  -e SSH_TUNNEL_LOCAL=80 \
  avinson/localhost-dot-run
  ```
