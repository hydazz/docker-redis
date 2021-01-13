#!/bin/bash

OVERLAY_VERSION=$(curl -sX GET "https://raw.githubusercontent.com/hydazz/docker-baseimage-alpine/main/version_info.json" | jq -r .overlay_version)

OLD_OVERLAY_VERSION=$(cat version_info.json | jq -r .overlay_version)
OLD_REDIS_RELEASE=$(cat version_info.json | jq -r .redis_version)

sed -i \
	-e "s/${OLD_OVERLAY_VERSION}/${OVERLAY_VERSION}/g" \
	-e "s/${OLD_REDIS_RELEASE}/${REDIS_RELEASE}/g" \
	README.md

NEW_VERSION_INFO="overlay_version|redis_version
${OVERLAY_VERSION}|${REDIS_RELEASE}"

jq -Rn '
( input  | split("|") ) as $keys |
( inputs | split("|") ) as $vals |
[[$keys, $vals] | transpose[] | {key:.[0],value:.[1]}] | from_entries
' <<<"$NEW_VERSION_INFO" >version_info.json
