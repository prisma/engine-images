FROM debian:jessie

RUN apt-get update
RUN apt-get install -y curl wget pkg-config build-essential git zlib1g-dev libkrb5-dev

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH

RUN wget https://www.openssl.org/source/openssl-1.0.1u.tar.gz
RUN tar -xf openssl-1.0.1u.tar.gz
RUN cd openssl-1.0.1u && ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib && make
RUN cd openssl-1.0.1u && make test
RUN cd openssl-1.0.1u && make install
RUN cd /etc/ld.so.conf.d/ && echo "/usr/local/ssl/lib" > openssl-1.0.1u.conf
RUN ldconfig -v

ENV PATH=/usr/local/ssl/bin:$PATH
ENV OPENSSL_DIR /usr/local/ssl
ENV OPENSSL_LIB_DIR /usr/local/ssl/lib
