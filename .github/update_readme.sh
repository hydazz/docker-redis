#!/bin/bash

sed -i -E \
	-e "s/redis-.*?-DC382D/redis-${APP_VERSION}-DC382D/g" \
	README.md
