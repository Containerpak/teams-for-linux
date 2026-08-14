FROM ubuntu:26.04 AS source

ADD --checksum=sha256:c65281d7991d8cec60903d852e5b2a8d8b831d6f7dd032ea7f6b63030aa7a504 https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v2.14.1/teams-for-linux_2.14.1_amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/teams-for-linux.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/teams-for-linux.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/teams-for-linux.deb && \
    ln -sf /opt/teams-for-linux/teams-for-linux /usr/bin/teams-for-linux && \
    cpak-clean-junk
