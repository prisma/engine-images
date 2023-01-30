FROM --platform=linux/arm64/v8 alpine AS alpine

# RUN apk add openssl-dev zlib-dev linux-headers
RUN apk add linux-headers

FROM --platform=linux/amd64 debian:bullseye

ENV PATH=/root/.cargo/bin:$PATH

# most steps taken from: https://stackoverflow.com/questions/60821697/how-to-build-openssl-for-arm-linux
# RUN apt-get update && apt-get -y install wget curl git make build-essential clang libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64 g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev gcc-aarch64-linux-gnu

# # cross compile OpenSSL
# # latest version can be found here: https://www.openssl.org/source/
# ENV OPENSSL_VERSION=openssl-3.0.2
# ENV DOWNLOAD_SITE=https://www.openssl.org/source
# RUN wget $DOWNLOAD_SITE/$OPENSSL_VERSION.tar.gz && tar zxf $OPENSSL_VERSION.tar.gz
# RUN cd $OPENSSL_VERSION && ./Configure linux-aarch64 --cross-compile-prefix=/usr/bin/aarch64-linux-gnu- --prefix=/opt/openssl-arm --openssldir=/opt/openssl-arm -static && make install

# # This env var configures rust-openssl to use the cross compiled version
# ENV OPENSSL_DIR=/opt/openssl-arm

# # Install Rust
# RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
# RUN rustup target add aarch64-unknown-linux-gnu
# RUN rustup component add clippy

# # from rust cross - https://github.com/rust-embedded/cross/blob/master/docker/Dockerfile.aarch64-unknown-linux-gnu#L27
# ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
# ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_RUNNER="/linux-runner aarch64"
# ENV CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc
# ENV CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++
# ENV QEMU_LD_PREFIX=/usr/aarch64-linux-gnu

# ----------------

ARG ZLIB_VERSION=1.2.13
ARG OPENSSL_VERSION=3.0.7

RUN dpkg --add-architecture arm64 && apt-get update
RUN apt-get -y install curl git build-essential clang-13 \
    gcc-aarch64-linux-gnu g++-aarch64-linux-gnu musl-dev:arm64
# binutils-multiarch?

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add aarch64-unknown-linux-musl

COPY ./aarch64-musl/musl-clang /bin/aarch64-musl-clang
COPY ./aarch64-musl/musl-gcc /bin/aarch64-musl-gcc
COPY ./aarch64-musl/musl-g++ /bin/aarch64-musl-g++
COPY ./aarch64-musl/musl-gcc.specs /lib/aarch64-linux-musl/musl-gcc.specs

ENV CC=aarch64-musl-gcc
ENV CXX=aarch64-musl-g++
ENV AR=aarch64-linux-gnu-ar
ENV AS=aarch64-linux-gnu-as
ENV RANLIB=aarch64-linux-gnu-ranlib

RUN mkdir -p /opt/cross/include # /opt/cross/lib
# COPY --from=alpine /usr/include/openssl /opt/cross/include/openssl
# COPY --from=alpine /usr/include/zconf.h /opt/cross/include/
# COPY --from=alpine /usr/include/zlib.h /opt/cross/include/
# COPY --from=alpine /lib/libz.so* /opt/cross/lib/
# COPY --from=alpine /lib/libssl.so* /opt/cross/lib/
# COPY --from=alpine /lib/libcrypto.so* /opt/cross/lib/

COPY --from=alpine /usr/include/linux /opt/cross/include/linux
COPY --from=alpine /usr/include/asm /opt/cross/include/asm
COPY --from=alpine /usr/include/asm-generic /opt/cross/include/asm-generic

RUN curl -fLO http://zlib.net/zlib-$ZLIB_VERSION.tar.xz && \
    tar xJf zlib-$ZLIB_VERSION.tar.xz
RUN cd zlib-$ZLIB_VERSION && \
    ./configure --prefix=/opt/cross && \
    make -j8 && make install

RUN curl -fLO https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz && \
    tar xzf openssl-$OPENSSL_VERSION.tar.gz
RUN cd openssl-$OPENSSL_VERSION && \
    # ./Configure shared zlib linux-aarch64 --prefix=/opt/cross --openssldir=/opt/cross -DOPENSSL_NO_SECURE_MEMORY && \
    ./Configure -static zlib linux-aarch64 --prefix=/opt/cross --openssldir=/opt/cross && \
    make -j8 && make install_sw install_ssldirs

ENV OPENSSL_DIR=/opt/cross

# Unset variables used during cross-compilation
# ENV CC=
# ENV CXX=
# ENV AR=
# ENV AS=
# ENV RANLIB=

ENV RUSTFLAGS="-C target-feature=-crt-static -C linker=/bin/aarch64-musl-clang"
ENV CC_aarch64_unknown_linux_musl=aarch64-musl-gcc
ENV CXX_aarch64_unknown_linux_musl=aarch64-musl-g++
