FROM ubuntu:26.04 AS source

ADD --checksum=sha256:c047a0d87189002369fa891a1db37d3740b80d449242bb672b63a7d68b459a2f https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v2.18.1/teams-for-linux_2.18.1_amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/teams-for-linux.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/teams-for-linux.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/teams-for-linux.deb && \
    ln -sf /opt/teams-for-linux/teams-for-linux /usr/bin/teams-for-linux && \
    cpak-clean-junk
