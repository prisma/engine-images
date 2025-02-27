FROM debian:bookworm

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install curl git

ARG ZIG_VERSION=0.11.0-dev.3348+3faf376b0
RUN cd /opt && curl -O https://ziglang.org/builds/zig-linux-x86_64-${ZIG_VERSION}.tar.xz && \
    tar xJf zig-linux-x86_64-${ZIG_VERSION}.tar.xz
ENV PATH=/opt/zig-linux-x86_64-${ZIG_VERSION}:$PATH

ENV PATH=/root/.cargo/bin:$PATH
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add aarch64-unknown-linux-gnu

RUN cargo install cargo-zigbuild

ENV CC="zig cc -target aarch64-linux-gnu.2.17"
ENV CXX="zig c++ -target aarch64-linux-gnu.2.17"
ENV AS="zig as -target aarch64-linux-gnu.2.17"
ENV AR="zig ar"
ENV RANLIB="zig ranlib"

ARG OPENSSL_1_1_VERSION=1.1.1u
ARG OPENSSL_3_0_VERSION=3.0.9

# Accepts 1.1.x or 3.0.x as a build arg
# ARG OPENSSL_VARIANT=3.0.x

ENV OPENSSL_VERSION=${OPENSSL_3_0_VERSION}

RUN curl -fLO https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz && \
    tar xzf openssl-$OPENSSL_VERSION.tar.gz

RUN cd openssl-$OPENSSL_VERSION && \
    ./Configure shared linux-aarch64 no-tests --prefix=/opt/cross --openssldir=/opt/cross && \
    make -j8 && make install_sw install_ssldirs

ENV OPENSSL_DIR=/opt/cross
