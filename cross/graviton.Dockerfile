# most steps taken from: https://stackoverflow.com/questions/60821697/how-to-build-openssl-for-arm-linux
FROM debian:stretch

ENV PATH=/root/.cargo/bin:$PATH

RUN apt-get update && apt-get -y install wget curl git make build-essential clang libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64 g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev
# added by me
RUN apt-get -y install gcc-aarch64-linux-gnu

# cross compile OpenSSL
RUN wget https://www.openssl.org/source/openssl-1.1.1e.tar.gz && tar zxf openssl-1.1.1e.tar.gz
RUN wget "https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&la=en&hash=0A37024B42028A9616F56A51C2D20755C5EBBCD7" -O gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz
RUN mkdir -p /opt/arm/9 && tar Jxf gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz -C /opt/arm/9
RUN cd openssl-1.1.1e && ./Configure linux-aarch64 --cross-compile-prefix=/opt/arm/9/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu- --prefix=/opt/openssl-1.1.1e --openssldir=/opt/openssl-1.1.1e -static && make install
# This env var configures rust-openssl to use the cross compiled version
ENV OPENSSL_DIR=/opt/openssl-1.1.1e

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add aarch64-unknown-linux-gnu

# from rust cross
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_RUNNER="/linux-runner aarch64"
ENV CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc
ENV CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++
ENV QEMU_LD_PREFIX=/usr/aarch64-linux-gnu
# set the target for cross compiling
RUN echo "[target.aarch64-unknown-linux-gnu]" >> ~/.cargo/config