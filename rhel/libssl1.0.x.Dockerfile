FROM centos:8

RUN yum groupinstall 'Development Tools' -y
RUN yum install wget git curl perl-core zlib-devel -y

# Install Rust
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup default stable

RUN yum install -y wget

RUN wget -c https://www.openssl.org/source/openssl-1.0.2p.tar.gz
RUN tar -xzvf openssl-1.0.2p.tar.gz

RUN cd openssl-1.0.2p && ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib && make

# RUN cd openssl-1.0.2p && make test
RUN cd openssl-1.0.2p && make install
COPY openssl.sh /etc/profile.d/openssl.sh
RUN chmod +x /etc/profile.d/openssl.sh
RUN cd /etc/ld.so.conf.d/ && echo "/usr/local/ssl/lib" > openssl-1.0.2p.conf
RUN ldconfig -v

ENV PATH=/usr/local/ssl/bin:$PATH
ENV OPENSSL_DIR /usr/local/ssl
ENV OPENSSL_LIB_DIR /usr/local/ssl/lib
