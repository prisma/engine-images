#
# Adapted from https://github.com/hseeberger/scala-sbt
# Changes:
#   - Pinned scala version to 2.12.3 instead of 2.12.4
#   - Added docker to installation
#   - Added rust stack
#   - Added Graal
#
# Docker image responsible for building Prisma service images.
#

# Pull base image
FROM openjdk:8u151

# Env variables
ENV SCALA_VERSION 2.12.3
ENV SBT_VERSION 1.0.4

# Scala expects this file
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release

# Install Scala
RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/

# Install Rust
RUN \
  curl https://sh.rustup.rs -sSf -o rustup_install.sh && \
  chmod +x rustup_install.sh && \
  ./rustup_install.sh -y && \
  rm rustup_install.sh

# SBT doesn't handle env vars properly, so just link it on the default path
RUN ln -s ~/.cargo/bin/* /usr/bin/

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

# Install graal
RUN mkdir /graalvm && \
  curl -L --output graal.tar.gz https://github.com/oracle/graal/releases/download/vm-1.0.0-rc9/graalvm-ce-1.0.0-rc9-linux-amd64.tar.gz && \
  tar xzf graal.tar.gz -C /graalvm && \
  rm -rf graalvm.tar.gz

ENV PATH /graalvm/Contents/Home/bin:$PATH
ENV GRAAL_HOME /graalvm/Contents/Home

# Install aux. tools
RUN apt-get install make gcc -y

# Install docker
RUN curl -sSL https://get.docker.com/ | sh

# Define working directory
WORKDIR /root
