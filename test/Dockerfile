FROM debian:buster

# Env variables
ENV SCALA_VERSION 2.12.3
ENV SBT_VERSION 1.2.3
ENV SBT_HOME /usr/local/sbt
ENV SCALA_HOME /usr/local/scala
ENV PATH ${SCALA_HOME}/bin:${SBT_HOME}/bin:/root/.cargo/bin:$PATH
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/include/linux:/lib/x86_64-linux-gnu

# Dependencies
RUN apt-get update && apt-get -y install wget curl git make build-essential libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64 libkrb5-dev libgss-dev libclang-dev libc6-dev libclang-common-7-dev software-properties-common clang
RUN apt-get -y install llvm
RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
RUN add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
RUN apt-get update && apt-get -y install adoptopenjdk-8-hotspot
RUN mkdir -p $SCALA_HOME
RUN mkdir -p $SBT_HOME

# Install Docker
RUN curl -sSL https://get.docker.com/ | sh

# Install Scala & SBT & Rust
RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C $SCALA_HOME --strip-components 1
RUN curl -fsL https://piccolo.link/sbt-${SBT_VERSION}.tgz | tar xfz - -C $SBT_HOME --strip-components 1
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Initialize SBT
RUN sbt exit
