FROM centos:8

RUN yum groupinstall 'Development Tools' -y

# Install Rust
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup default stable
