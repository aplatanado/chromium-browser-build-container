FROM ubuntu:18.04

ARG DEB_PACKAGE=chromium-browser
ARG BUILD_DIR=/build

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        fakeroot \
        devscripts \
    && apt-get build-dep -y $DEB_PACKAGE

WORKDIR /src
COPY patches patches/

RUN apt-get source -y $DEB_PACKAGE \
    && cd $(ls --group-directories-first | head -1) \
    && debchange -l "+local." "Local version" \
    && cat ../patches/*.patch | patch -p1 \
    && debuild -us -uc -i -I -b \
    && cp --verbose ../*.deb $BUILD_DIR

ENTRYPOINT []
