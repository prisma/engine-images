FROM debian:stretch

RUN apt-get update
RUN apt-get install -y libssl1.0.2 curl

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH
RUN rustup install beta && rustup default beta

