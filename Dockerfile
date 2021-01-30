ARG TAG
FROM vcxpz/baseimage-alpine:${TAG}

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Redis version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

RUN \
	echo "**** install runtime packages ****" && \
	apk add --no-cache --upgrade \
		redis && \
	rm -rf \
		/tmp/*

# add local files
COPY root/ /

# redis healthcheck
HEALTHCHECK --start-period=10s --timeout=5s \
	CMD redis-cli ping || exit 1

# ports and volumes
EXPOSE 6379
VOLUME /config
