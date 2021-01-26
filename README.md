## docker-redis

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/redis) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/redis?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-redis/actions?query=workflow%3A"Auto+Builder+CI") [![codacy branch grade](https://img.shields.io/codacy/grade/d1fcacdcdb474e13b65b709a215ae17b/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-redis)

[Redis](https://redis.io/) is an in-memory data structure store, used as a distributed, in-memory key–value database, cache and message broker, with optional durability.

## Customisation (redis.conf)

This container uses redis.conf rather than specifying everything in the `redis-server` run command like most other images. This file is located in the config folder (`/config/redis.conf` within the container) and can be customised to your hearts content. The defaults are fine for most use cases. If you need help customising this file see [here](https://redis.io/topics/config).

## Version Information

![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![redis](https://img.shields.io/badge/redis-6.0.10-DC382D?style=for-the-badge&logo=redis)

See [package_versions.txt](package_versions.txt) for a full list of the packages and package versions used in this image

## Usage

    docker run -d \
      --name=redis \
      -e PUID=1000 \
      -e PGID=1000 \
      -e TZ=Australia/Melbourne \
      -p 6379:6379 \
      -v <path to appdata>:/config \
      --restart unless-stopped \
      vcxpz/redis

[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/redis.xml)

## Upgrading Redis

To upgrade, all you have to do is pull the latest Docker image. We automatically check for Redis updates daily so there may be some delay when an update is released to when the image is updated.
