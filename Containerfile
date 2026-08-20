FROM ubuntu:26.04 AS source

ADD --checksum=sha256:80283457504e6bc46fbb14772316688bbcae653e67073838cfa338b5c40f1bdb https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v2.17.0/teams-for-linux_2.17.0_amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/teams-for-linux.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/teams-for-linux.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/teams-for-linux.deb && \
    ln -sf /opt/teams-for-linux/teams-for-linux /usr/bin/teams-for-linux && \
    cpak-clean-junk
