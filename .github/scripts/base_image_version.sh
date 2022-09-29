#!/bin/sh
set -e
VERSION=$(cat Dockerfile | perl -ne '/from [^:]+:([^- ]+)/i && print "$1"')
echo "${PREFIX}${VERSION}${SUFFIX}"
