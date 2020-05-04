#!/bin/bash
#
# Build a local version of Chromium Browser
#

set -e

IMAGE_TAG=chromium-browser-build
BUILD_DIR="${1:-$PWD/build}"
BUILD_ARGS=

mkdir -p "$BUILD_DIR"
podman build \
    --tag $IMAGE_TAG \
    --volume "$BUILD_DIR":/build \
    $BUILD_ARGS .
