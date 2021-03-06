FROM vcxpz/baseimage-alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Redis version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

RUN set -xe && \
	echo "**** install build packages ****" && \
	apk add --no-cache --virtual=build-dependencies \
		curl && \
	echo "**** install runtime packages ****" && \
	if [ -z ${VERSION} ]; then \
		VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp && \
			awk '/^P:redis$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
	fi && \
	apk add --no-cache \
		redis=="${VERSION}" && \
	echo "**** cleanup ****" && \
	apk del --purge \
		build-dependencies && \
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
