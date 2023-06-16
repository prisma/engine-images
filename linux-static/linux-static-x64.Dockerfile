FROM debian:bookworm

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install build-essential curl musl-tools git

RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup target add x86_64-unknown-linux-musl
