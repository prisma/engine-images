FROM debian:bullseye

# Env variables
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/include/linux:/lib/x86_64-linux-gnu

# Dependencies
RUN apt-get update && apt-get -y install wget curl git make build-essential libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64 libkrb5-dev libgss-dev libclang-dev libc6-dev software-properties-common clang
RUN apt-get -y install llvm

# Install Docker
RUN curl -sSL https://get.docker.com/ | sh

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
