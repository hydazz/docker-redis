FROM vcxpz/baseimage-alpine

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Redis version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Alex Hyde"

RUN \
   echo "**** install runtime packages ****" && \
   apk add --no-cache --upgrade \
      redis && \
   echo "**** cleanup ****" && \
   rm -rf \
      /tmp/* \
      /etc/redis.conf

# add local files
COPY root/ /

# ports and volumes
EXPOSE 6379
VOLUME /config
