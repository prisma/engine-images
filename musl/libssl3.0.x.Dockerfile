FROM rust:alpine

ENV RUSTFLAGS="-C target-feature=-crt-static" \
  PROTOC_INCLUDE="/usr/include" \
  PROTOC="/usr/bin/protoc"

RUN apk update && \
  apk add perl musl-dev build-base bash clang git protoc protobuf protobuf-dev wget linux-headers

RUN wget -c https://www.openssl.org/source/openssl-3.0.7.tar.gz
RUN tar -xzvf openssl-3.0.7.tar.gz

RUN cd openssl-3.0.7 && ./config --prefix=/usr --openssldir=/usr shared zlib && make -j8

RUN cd openssl-3.0.7 && make install
RUN cd /etc && echo "/usr/lib64:/lib:/usr/lib:/usr/local/lib" > ld-musl-x86_64.path

ENV OPENSSL_DIR /usr
ENV OPENSSL_LIB_DIR /usr/lib64
