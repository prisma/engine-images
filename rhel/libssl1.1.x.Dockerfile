FROM centos:6

RUN yum groupinstall 'Development Tools' -y
RUN yum install git curl pkg-config perl-core zlib-devel wget -y

# Install Rust
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH

RUN wget https://www.openssl.org/source/openssl-1.1.0i.tar.gz
RUN tar -xf openssl-1.1.0i.tar.gz
RUN cd openssl-1.1.0i && ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib && make
# RUN cd openssl-1.1.0i && make test
RUN cd openssl-1.1.0i && make install
COPY openssl.sh /etc/profile.d/openssl.sh
RUN chmod +x /etc/profile.d/openssl.sh
RUN cd /etc/ld.so.conf.d/ && echo "/usr/local/ssl/lib" > openssl-1.1.0i.conf
RUN ldconfig -v

ENV PATH=/usr/local/ssl/bin:$PATH
ENV OPENSSL_DIR /usr/local/ssl
ENV OPENSSL_LIB_DIR /usr/local/ssl/lib
