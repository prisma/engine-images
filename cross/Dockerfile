FROM debian:stretch

ENV PATH=/root/.cargo/bin:$PATH
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/include/linux:/lib/x86_64-linux-gnu

RUN apt-get update && apt-get -y install wget curl git make build-essential libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup install beta && rustup default beta
RUN rustup target add x86_64-pc-windows-gnu

RUN echo "[target.x86_64-pc-windows-gnu]" >> ~/.cargo/config
RUN echo "linker = \"/usr/bin/x86_64-w64-mingw32-gcc\"" >> ~/.cargo/config