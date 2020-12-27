## Redis on Alpine edge + s6 overlay + logrotate
[Redis](https://redis.io/) is an in-memory data structure store, used as a distributed, in-memory key–value database, cache and message broker, with optional durability.

[![docker Hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/redis) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/redis?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/auto_build-weekly-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-redis/actions?query=workflow%3A%22Cron+Update+CI%22)

## Customisation (redis.conf)
This container uses redis.conf rather than specifying everything in the redis-server run command like most other images. This file is located in the config folder (`/config/redis.conf` within the container) and can be customised to your hearts content. The defaults are fine for most use cases. If you need help customising this file see [here](https://redis.io/topics/config)

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6 overlay](https://img.shields.io/badge/s6_overlay-2.1.0.2-blue?style=for-the-badge) ![redis](https://img.shields.io/badge/redis-6.0.9-DC382D?style=for-the-badge&logo=redis)

## Usage
```
docker run -d \
  --name=redis \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -p 6379:6379 \
  -v <path to appdata>:/config \
  --restart unless-stopped \
  vcxpz/redis
```

## Todo
* Nothing, everything works 🙂
