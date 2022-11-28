FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y curl wget pkg-config build-essential git zlib1g-dev libkrb5-dev libgss-dev libclang-dev ca-certificates

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH

# DST expiration workaround
RUN sed '/DST_Root_CA_X3.crt/d' /etc/ca-certificates.conf > /tmp/cacerts.conf && mv /tmp/cacerts.conf /etc/ca-certificates.conf
RUN update-ca-certificates

RUN wget https://www.openssl.org/source/openssl-3.0.2.tar.gz
RUN tar -xf openssl-3.0.2.tar.gz
RUN cd openssl-3.0.2 && ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib && make
# RUN cd openssl-3.0.2 && make test
RUN cd openssl-3.0.2 && make install
RUN cd /etc/ld.so.conf.d/ && echo "/usr/local/ssl/lib64" > openssl-3.0.2.conf
RUN ldconfig -v

ENV PATH=/usr/local/ssl/bin:$PATH
ENV OPENSSL_DIR /usr/local/ssl
ENV OPENSSL_LIB_DIR /usr/local/ssl/lib64
