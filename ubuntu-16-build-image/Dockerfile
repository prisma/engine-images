FROM ubuntu:16.04

# Env variables
ENV PATH bin:/root/.cargo/bin:$PATH

# Install deps
RUN apt-get update && apt-get -y install curl git make build-essential libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip

# Install Docker
RUN curl -sSL https://get.docker.com/ | sh

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup install beta && rustup default beta

# Define working directory
WORKDIR /root
