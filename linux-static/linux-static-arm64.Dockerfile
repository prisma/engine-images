FROM debian:bookworm

ENV PATH=/root/.cargo/bin:/opt/cross/bin:$PATH

RUN apt-get update && \
    apt-get install -y build-essential curl file git bison flex

COPY ./aarch64-musl-config.mak /tmp/config.mak

# Build cross-compiling toolchain using https://github.com/richfelker/musl-cross-make,
# https://github.com/rust-cross/rust-musl-cross.
# See also `../cross/linux-musl-arm.Dockerfile`.
RUN cd /tmp && \
    git clone --depth 1 https://github.com/richfelker/musl-cross-make.git --branch v0.9.10 && \
    cp /tmp/config.mak /tmp/musl-cross-make/config.mak && \
    cd /tmp/musl-cross-make && \
    export CFLAGS="-fPIC -g1" && \
    export TARGET=aarch64-unknown-linux-musl && \
    make -j$(nproc) && make install && \
    cd /tmp && rm -rf /tmp/musl-cross-make

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add aarch64-unknown-linux-musl

RUN echo '[target.aarch64-unknown-linux-musl]' > /root/.cargo/config && \
    echo 'linker = "aarch64-unknown-linux-musl-gcc"' >> /root/.cargo/config

ENV CC_aarch64_unknown_linux_musl=aarch64-unknown-linux-musl-gcc
ENV CXX_aarch64_unknown_linux_musl=aarch64-unknown-linux-musl-g++
