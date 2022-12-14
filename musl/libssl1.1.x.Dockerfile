FROM rust:alpine3.15

ENV RUSTFLAGS="-C target-feature=-crt-static" \
  PROTOC_INCLUDE="/usr/include" \
  PROTOC="/usr/bin/protoc"

RUN apk update && \
  apk add perl musl-dev build-base bash clang git protoc protobuf protobuf-dev wget linux-headers

RUN wget -c https://www.openssl.org/source/openssl-1.1.1s.tar.gz
RUN tar -xzvf openssl-1.1.1s.tar.gz

RUN cd openssl-1.1.1s && ./config --prefix=/usr --openssldir=/usr shared zlib && make -j8

RUN cd openssl-1.1.1s && make install

ENV OPENSSL_DIR /usr
ENV OPENSSL_LIB_DIR /usr/lib
