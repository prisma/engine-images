# Use the ZLIB_VERSION, OPENSSL_1_1_VERSION, OPENSSL_3_0_VERSION and
# OPENSSL_VARIANT build args to configure the image. See their definitions and
# the default values below in the file -- they are defined right before usage
# for better caching of layers.

FROM --platform=linux/arm64/v8 alpine AS alpine

# This one step runs in emulation, that's why we use "docker buildx build" in
# Makefile to ensure BuildKit is enabled. Optimally we would've just used the
# linux-musl-dev:arm64 package in debian, but it doesn't seem to exist anymore
# althogh it's referenced by other packages, so using the multi-stage image like
# this seems to be the easiest option. An alternative would've been to download
# the linux source tarball and grab the headers from there, or download the
# normal arm64 linux header package in Debian and manually unpack it it without
# installing.
RUN apk add linux-headers

FROM --platform=linux/amd64 debian:bullseye

ENV PATH=/root/.cargo/bin:$PATH

RUN dpkg --add-architecture arm64 && apt-get update
RUN apt-get -y install curl git build-essential clang-13 \
    gcc-aarch64-linux-gnu g++-aarch64-linux-gnu musl-dev:arm64

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

RUN mkdir -p /opt/cross/include

COPY --from=alpine /usr/include/linux /opt/cross/include/linux
COPY --from=alpine /usr/include/asm /opt/cross/include/asm
COPY --from=alpine /usr/include/asm-generic /opt/cross/include/asm-generic

ARG ZLIB_VERSION=1.2.13

RUN curl -fLO http://zlib.net/zlib-$ZLIB_VERSION.tar.xz && \
    tar xJf zlib-$ZLIB_VERSION.tar.xz
RUN cd zlib-$ZLIB_VERSION && \
    ./configure --prefix=/opt/cross && \
    make -j8 && make install

ARG OPENSSL_1_1_VERSION=1.1.1s
ARG OPENSSL_3_0_VERSION=3.0.7

# Accepts 1.1.x or 3.0.x as a build arg
ARG OPENSSL_VARIANT=3.0.x

RUN if [ "$OPENSSL_VARIANT" = "3.0.x" ]; then \
        OPENSSL_VERSION="$OPENSSL_3_0_VERSION"; \
    elif [ "$OPENSSL_VARIANT" = "1.1.x" ]; then \
        OPENSSL_VERSION="$OPENSSL_1_1_VERSION"; \
    else \
        >&2 echo "wrong openssl variant: $OPENSSL_VARIANT"; \
        exit 1; \
    fi && \
    curl -fLO https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz && \
    tar xzf openssl-$OPENSSL_VERSION.tar.gz && \
    cd openssl-$OPENSSL_VERSION && \
    ./Configure -static zlib linux-aarch64 --prefix=/opt/cross --openssldir=/opt/cross && \
    make -j8 && make install_sw install_ssldirs

ENV OPENSSL_DIR=/opt/cross

# Unset variables used during cross-compilation of zlib and
# openssl. `CC_aarch64_unknown_linux_musl` and `CXX_aarch64_unknown_linux_musl`,
# which are necessary for cross-compilation of C code in sys crates, are set
# below instead. When CC/CXX are used there, they are actually used to compile
# temporary binaries to run on the host system during the build, so using a
# cross compiler there is not something we currently want. Sometimes though it
# might be be easier to use the cross compiler for everything though and set up
# QEMU usermode emulation with binfmt_misc to run the non-native binaries at
# build time -- consider this if issues with new dependencies arise in the
# future.
ENV CC=
ENV CXX=
ENV AR=
ENV AS=
ENV RANLIB=

ENV RUSTFLAGS="-C target-feature=-crt-static -C linker=/bin/aarch64-musl-clang"
ENV CC_aarch64_unknown_linux_musl=aarch64-musl-gcc
ENV CXX_aarch64_unknown_linux_musl=aarch64-musl-g++
