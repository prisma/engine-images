FROM centos:7

RUN yum groupinstall 'Development Tools' -y
RUN yum install git curl pkg-config openssl-devel krb5-devel gss-devel clang-devel -y

# Install Rust
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup default stable
