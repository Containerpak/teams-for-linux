FROM ubuntu:26.04 AS source

ADD --checksum=sha256:da00972366b49fb688e511029234f0ac3e2df3c4b34521b424b1210bb5262774 https://github.com/IsmaelMartinez/teams-for-linux/releases/download/v2.17.1/teams-for-linux_2.17.1_amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/teams-for-linux.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/teams-for-linux.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/teams-for-linux.deb && \
    ln -sf /opt/teams-for-linux/teams-for-linux /usr/bin/teams-for-linux && \
    cpak-clean-junk
