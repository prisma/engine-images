FROM frolvlad/alpine-glibc

RUN apk add --no-cache curl bash gcc build-base openssl openssl-dev linux-headers

RUN curl https://sh.rustup.rs -o rustup-init
RUN chmod +x rustup-init
RUN ./rustup-init --verbose -y --no-modify-path --default-host x86_64-unknown-linux-gnu
RUN rm rustup-init

ENV PATH=/root/.cargo/bin:"$PATH"
RUN rustup target add x86_64-unknown-linux-musl
RUN rustup update
RUN rustc -Vv

ENV PKG_CONFIG_ALLOW_CROSS=1

WORKDIR /root