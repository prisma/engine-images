FROM amazonlinux:1

RUN yum groupinstall 'Development Tools' -y
RUN yum install wget git curl perl-core zlib-devel openssl openssl-devel -y

# Install Rust
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup default stable
RUN rustup component add clippy
