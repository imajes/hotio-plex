FROM hotio/base@sha256:a97ec69084f2db5bc2603e79e905c34595ea1fe78e1143d0beaf2b1c7b4a9087

ARG DEBIAN_FRONTEND="noninteractive"

ENV PLEX_CLAIM="" ADVERTISE_IP="" ALLOWED_NETWORKS="" PLEX_PASS="no" DISABLE_RELAY="no"

EXPOSE 32400/tcp 3005/tcp 8324/tcp 32469/tcp 1900/udp 32410/udp 32412/udp 32413/udp 32414/udp

VOLUME ["/transcode"]

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        xmlstarlet uuid-runtime && \
# clean up
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG PLEX_VERSION=1.18.4.2171-ac2afe5f8

# install app
RUN debfile="/tmp/plex.deb" && curl -fsSL -o "${debfile}" "https://downloads.plex.tv/plex-media-server-new/${PLEX_VERSION}/debian/plexmediaserver_${PLEX_VERSION}_arm64.deb" && dpkg --install "${debfile}" && rm "${debfile}"

COPY root/ /
