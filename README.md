## Redis on Alpine Edge
[Redis](https://redis.io/) is an in-memory data structure store, used as a distributed, in-memory key–value database, cache and message broker, with optional durability.

[![Docker hub](https://img.shields.io/badge/docker%20hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/redis) ![Docker Image Size](https://img.shields.io/docker/image-size/vcxpz/redis?style=for-the-badge&logo=docker) [![Autobuild](https://img.shields.io/badge/auto%20build-disabled-grey?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-redis/actions?query=workflow%3A%22Cron+Update+CI%22)

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6overlay](https://img.shields.io/badge/s6--overlay-2.1.0.2-blue?style=for-the-badge) ![redis](https://img.shields.io/badge/redis-redisversion-DC382D?style=for-the-badge&logo=redis) [![moredetail](https://img.shields.io/badge/more-detail-blue?style=for-the-badge)](https://github.com/hydazz/docker-redis/blob/main/package_versions.txt)

## Usage
```
docker run -d \
  --name=redis \
  --cap-add=NET_ADMIN \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -p 6379:6379 \
  -v <path to appdata>:/config \
  --restart unless-stopped \
  vcxpz/redis
```

## Todo
* Test if redis works
