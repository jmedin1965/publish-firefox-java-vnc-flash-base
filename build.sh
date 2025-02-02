#!/bin/bash

name="amd64-addon-firefox-java-vnc-flash-base"

ver_tag="$(set -- $(grep -e '^#\s\+[0-9]\+\.[0-9]\+\.[0-9]\+\s*$' CHANGELOG.md | head -n 1); echo $2)"
ver_tag="${ver_tag##v}"
GIT_TAG="$(git describe --tags --abbrev=0 2> /dev/null)"

docker build -t "$name:latest" -t "$name:$ver_tag" . \
	&&  docker images | fgrep "$name"
