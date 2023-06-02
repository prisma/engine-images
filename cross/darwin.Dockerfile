# Credit to https://wapl.es/rust/2019/02/17/rust-cross-compile-linux-to-macos.html for most of the installation steps.
FROM debian:stretch

ENV PATH=/root/.cargo/bin:$PATH
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/include/linux:/lib/x86_64-linux-gnu

RUN echo 'deb http://archive.debian.org/debian stretch main' > /etc/apt/sources.list
RUN echo 'deb http://archive.debian.org/debian-security stretch/updates main' >> /etc/apt/sources.list

RUN apt-get update && apt-get -y install wget curl git make build-essential clang libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64 g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add x86_64-apple-darwin
RUN rustup component add clippy

# Install OSX cross toolchain
RUN apt-get install -y cmake libxml2-dev
COPY ./osxcross_setup.sh /root/osxcross_setup.sh
RUN cd /root && ./osxcross_setup.sh

# Configure cross compilation environment & cargo
ENV PATH="/root/osxcross/target/bin:$PATH"
ENV CC=o64-clang
ENV CXX=o64-clang++

RUN echo "[target.x86_64-apple-darwin]" >> ~/.cargo/config
RUN echo "linker = \"x86_64-apple-darwin14-clang\"" >> ~/.cargo/config
RUN echo "ar = \"x86_64-apple-darwin14-ar\"" >> ~/.cargo/config
RUN echo "rustflags = [\"-C\", \"link-args=-undefined dynamic_lookup\"]" >> ~/.cargo/config
