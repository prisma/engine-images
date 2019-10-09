FROM debian:stretch

# Env variables
ENV SCALA_VERSION 2.12.3
ENV SBT_VERSION 1.2.3
ENV SBT_HOME /usr/local/sbt
ENV SCALA_HOME /usr/local/scala
ENV PATH ${SCALA_HOME}/bin:${SBT_HOME}/bin:/root/.cargo/bin:$PATH
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/root/build/libs/jwt-native/src/main/resources:/usr/include/linux:/lib/x86_64-linux-gnu
ENV SCCACHE_DIR=/root/cargo_cache

RUN apt-get update && apt-get -y install wget curl git make build-essential libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64 openjdk-8-jdk
RUN mkdir -p $SCALA_HOME
RUN mkdir -p $SBT_HOME

RUN curl -sSL https://get.docker.com/ | sh

# Install Scala & SBT & Rust
RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C $SCALA_HOME --strip-components 1
RUN curl -fsL https://piccolo.link/sbt-${SBT_VERSION}.tgz | tar xfz - -C $SBT_HOME  --strip-components 1
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup install beta && rustup default beta

RUN rustup target add x86_64-pc-windows-gnu
RUN cargo install sccache

RUN echo "[target.x86_64-pc-windows-gnu]" >> ~/.cargo/config
RUN echo "linker = \"/usr/bin/x86_64-w64-mingw32-gcc\"" >> ~/.cargo/config

# Define working directory
WORKDIR /root
