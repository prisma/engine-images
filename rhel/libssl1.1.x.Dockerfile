FROM amazon/lambda-build-node10.x

RUN yum remove -y openssl-devel
RUN yum install -y openssl11 openssl11-devel

ENV OPENSSL_INCLUDE_DIR=/usr/include/openssl/
ENV OPENSSL_LIB_DIR=/lib64

# Install Rust
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup default stable
