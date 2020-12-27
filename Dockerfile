FROM vcxpz/baseimage-alpine

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Redis version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Alex Hyde"

RUN \
   echo "**** install build packages ****" && \
   apk add --no-cache --virtual=build-dependencies \
      coreutils \
      curl \
      dpkg-dev dpkg \
      gcc \
      linux-headers \
      make \
      musl-dev \
      openssl-dev && \
   mkdir -p /usr/src/redis && \
   echo "**** download redis ****" && \
   curl -o \
      /tmp/redis.tar.gz -L \
      "http://download.redis.io/releases/redis-${VERSION}.tar.gz" && \
   tar xzf \
      /tmp/redis.tar.gz -C \
      /usr/src/redis --strip-components=1 && \
   echo "**** configure redis for building ****" && \
   grep -E '^ *createBoolConfig[(]"protected-mode",.*, *1 *,.*[)],$' /usr/src/redis/src/config.c && \
   sed -ri 's!^( *createBoolConfig[(]"protected-mode",.*, *)1( *,.*[)],)$!\10\2!' /usr/src/redis/src/config.c && \
   grep -E '^ *createBoolConfig[(]"protected-mode",.*, *0 *,.*[)],$' /usr/src/redis/src/config.c && \
   gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" && \
   extraJemallocConfigureFlags="--build=$gnuArch" && \
   dpkgArch="$(dpkg --print-architecture)" && \
   case "${dpkgArch##*-}" in \
      amd64 | i386 | x32) extraJemallocConfigureFlags="$extraJemallocConfigureFlags --with-lg-page=12" ;; \
      *) extraJemallocConfigureFlags="$extraJemallocConfigureFlags --with-lg-page=16" ;; \
   esac && \
   extraJemallocConfigureFlags="$extraJemallocConfigureFlags --with-lg-hugepage=21" && \
   grep -F 'cd jemalloc && ./configure ' /usr/src/redis/deps/Makefile && \
   sed -ri 's!cd jemalloc && ./configure !&'"$extraJemallocConfigureFlags"' !' /usr/src/redis/deps/Makefile && \
   grep -F "cd jemalloc && ./configure $extraJemallocConfigureFlags " /usr/src/redis/deps/Makefile && \
   export BUILD_TLS=yes && \
   echo "**** build redis ****" && \
   make -C /usr/src/redis -j "$(nproc)" all && \
   make -C /usr/src/redis install && \
   echo "**** deduplicate redis-server copies ****" && \
   serverMd5="$(md5sum /usr/local/bin/redis-server | cut -d' ' -f1)"; export serverMd5; \
   find /usr/local/bin/redis* -maxdepth 0 \
      -type f -not -name redis-server \
      -exec sh -eux -c ' \
           md5="$(md5sum "$1" | cut -d" " -f1)"; \
           test "$md5" = "$serverMd5"; \
      ' -- '{}' ';' \
      -exec ln -svfT 'redis-server' '{}' ';' && \
   echo "**** cleanup ****" && \
   apk del --purge \
      build-dependencies && \
   rm -rf \
      /tmp/* \
      /etc/redis.conf \
      /usr/src/redis

# add local files
COPY root/ /

# ports and volumes
EXPOSE 6379
VOLUME /config
