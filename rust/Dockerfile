FROM rust:slim
RUN apt-get update && apt-get install libsqlite3-dev openssl libssl-dev pkg-config -y && apt-get clean
RUN rustup install beta && rustup default beta