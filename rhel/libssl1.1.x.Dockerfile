FROM centos:8

RUN yum install openssl-devel curl -y

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH
RUN rustup install beta && rustup default beta