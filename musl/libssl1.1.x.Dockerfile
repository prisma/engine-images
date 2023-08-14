FROM alpine:3.15

ENV PATH=/root/.cargo/bin:$PATH \
    RUSTFLAGS="-C target-feature=-crt-static" \
    PROTOC_INCLUDE="/usr/include" \
    PROTOC="/usr/bin/protoc"

RUN apk update && \
    apk add perl musl-dev build-base bash curl clang git protoc protobuf protobuf-dev linux-headers

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN curl -fLO https://www.openssl.org/source/openssl-1.1.1v.tar.gz
RUN tar -xzvf openssl-1.1.1v.tar.gz

RUN cd openssl-1.1.1v && ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib && make -j8

RUN cd openssl-1.1.1v && make install_sw install_ssldirs
RUN cd /etc && echo "/usr/local/ssl/lib:/lib:/usr/lib:/usr/local/lib" > ld-musl-x86_64.path

ENV OPENSSL_DIR /usr/local/ssl
ENV OPENSSL_LIB_DIR /usr/local/ssl/lib
