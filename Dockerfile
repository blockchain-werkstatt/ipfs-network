FROM alpine:edge

# Install Go Runtime Dependencies
# inspiration: https://github.com/stackhub/service-prometheus/blob/master/Dockerfile
ENV \
    ALPINE_GLIBC_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download/unreleased/" \
    GLIBC_PKG="glibc-2.25-r1.apk" \
    GLIBC_BIN_PKG="glibc-bin-2.25-r1.apk"
RUN \
    apk add --update -t deps wget ca-certificates openssl \
    && apk add --update -t openssl \
    && cd /tmp \
    && wget ${ALPINE_GLIBC_URL}${GLIBC_PKG} ${ALPINE_GLIBC_URL}${GLIBC_BIN_PKG} \
    && apk add --allow-untrusted ${GLIBC_PKG} ${GLIBC_BIN_PKG} \
    && apk del --purge deps \
    && rm /tmp/* /var/cache/apk/*


# Install and Run IPFS
ENV IPFS_PATH /ipfs/data

ADD go-ipfs_v0.4.8_linux-amd64.tar.gz .
RUN mv go-ipfs/ipfs /usr/local/bin/ipfs

VOLUME $IPFS_PATH

CMD (/usr/local/bin/ipfs init && \
	/usr/local/bin/ipfs daemon) || \
	/usr/local/bin/ipfs daemon

# Ports for Swarm TCP, Swarm uTP, API, Gateway
EXPOSE 4001 4002/udp 5001 8080