# most steps taken from: https://stackoverflow.com/questions/60821697/how-to-build-openssl-for-arm-linux
FROM debian:stretch

ENV PATH=/root/.cargo/bin:$PATH

RUN echo 'deb http://archive.debian.org/debian stretch main' > /etc/apt/sources.list
RUN echo 'deb http://archive.debian.org/debian-security stretch/updates main' >> /etc/apt/sources.list

RUN apt-get update && apt-get -y install wget curl git make build-essential clang libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64 g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev gcc-aarch64-linux-gnu

# cross compile OpenSSL
# latest version can be found here: https://www.openssl.org/source/
ENV OPENSSL_VERSION=openssl-1.1.1t
ENV DOWNLOAD_SITE=https://www.openssl.org/source
RUN wget $DOWNLOAD_SITE/$OPENSSL_VERSION.tar.gz && tar zxf $OPENSSL_VERSION.tar.gz
RUN cd $OPENSSL_VERSION && ./Configure linux-aarch64 --cross-compile-prefix=/usr/bin/aarch64-linux-gnu- --prefix=/opt/openssl-arm --openssldir=/opt/openssl-arm -static && make install

# This env var configures rust-openssl to use the cross compiled version
ENV OPENSSL_DIR=/opt/openssl-arm

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add aarch64-unknown-linux-gnu
RUN rustup component add clippy

# from rust cross - https://github.com/rust-embedded/cross/blob/master/docker/Dockerfile.aarch64-unknown-linux-gnu#L27
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_RUNNER="/linux-runner aarch64"
ENV CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc
ENV CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++
ENV QEMU_LD_PREFIX=/usr/aarch64-linux-gnu
