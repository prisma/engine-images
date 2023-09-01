# Use the OPENSSL_1_1_VERSION, OPENSSL_3_0_VERSION and OPENSSL_VARIANT build
# args to configure the image. See their definitions and the default values
# below in the file -- they are defined right before usage for better caching
# of layers.

FROM --platform=linux/amd64 debian:bookworm

ENV PATH=/root/.cargo/bin:/opt/cross/bin:$PATH

RUN apt-get update && \
    apt-get install -y build-essential curl file git bison flex

COPY ./aarch64-musl/config.mak /tmp/config.mak

# Build cross-compiling toolchain using https://github.com/richfelker/musl-cross-make,
# similar to https://github.com/rust-cross/rust-musl-cross
RUN cd /tmp && \
    git clone --depth 1 https://github.com/richfelker/musl-cross-make.git && \
    cp /tmp/config.mak /tmp/musl-cross-make/config.mak && \
    cd /tmp/musl-cross-make && \
    export CFLAGS="-fPIC -g1" && \
    export TARGET=aarch64-unknown-linux-musl && \
    make -j$(nproc) && make install && \
    cd /tmp && rm -rf /tmp/musl-cross-make

ARG OPENSSL_1_1_VERSION=1.1.1v
ARG OPENSSL_3_0_VERSION=3.0.10

# Accepts 1.1.x or 3.0.x as a build arg
ARG OPENSSL_VARIANT=3.0.x

ENV OPENSSL_DIR=/opt/cross

RUN if [ "$OPENSSL_VARIANT" = "3.0.x" ]; then \
        OPENSSL_VERSION="$OPENSSL_3_0_VERSION"; \
    elif [ "$OPENSSL_VARIANT" = "1.1.x" ]; then \
        OPENSSL_VERSION="$OPENSSL_1_1_VERSION"; \
    else \
        >&2 echo "wrong openssl variant: $OPENSSL_VARIANT"; \
        exit 1; \
    fi && \
    cd /tmp && \
    curl -fLO https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz && \
    tar xzf openssl-$OPENSSL_VERSION.tar.gz && \
    cd openssl-$OPENSSL_VERSION && \
    ./Configure linux-aarch64 --cross-compile-prefix=aarch64-unknown-linux-musl- \
        --prefix=$OPENSSL_DIR --openssldir=$OPENSSL_DIR \
        shared no-tests no-comp no-zlib no-zlib-dynamic && \
    make -j$(nproc) && make install_sw install_ssldirs && \
    cd /tmp && rm -rf /tmp/openssl-$OPENSSL_VERSION

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add aarch64-unknown-linux-musl

RUN echo '[target.aarch64-unknown-linux-musl]' > /root/.cargo/config && \
    echo 'linker = "aarch64-unknown-linux-musl-gcc"' >> /root/.cargo/config

ENV RUSTFLAGS="-C target-feature=-crt-static"
ENV CC_aarch64_unknown_linux_musl=aarch64-unknown-linux-musl-gcc
ENV CXX_aarch64_unknown_linux_musl=aarch64-unknown-linux-musl-g++
