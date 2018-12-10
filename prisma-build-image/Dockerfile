# Pull base image
FROM alpine:3.8

# Env variables
ENV SCALA_VERSION 2.12.3
ENV SBT_VERSION 1.2.3
ENV GRAAL_HOME /graalvm/Contents/Home
ENV JAVA_HOME /graalvm/Contents/Home
ENV SBT_HOME /usr/local/sbt
ENV SCALA_HOME /usr/local/scala
ENV PATH ${GRAAL_HOME}/bin:${SCALA_HOME}/bin:${SBT_HOME}/bin:$PATH
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/root/server/libs/jwt-native/src/main/resources

RUN apk add --no-cache curl bash ca-certificates make gcc docker wget zlib-dev git ncurses musl-dev
RUN mkdir -p $GRAAL_HOME
RUN mkdir -p $SCALA_HOME
RUN mkdir -p $SBT_HOME
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk
RUN apk add glibc-2.28-r0.apk

# Install graal
RUN \
  curl -L --output graal.tar.gz https://github.com/oracle/graal/releases/download/vm-1.0.0-rc9/graalvm-ce-1.0.0-rc9-linux-amd64.tar.gz && \
  tar xzf graal.tar.gz -C ${GRAAL_HOME} --strip-components 1 && \
  rm -rf /graalvm.tar.gz

# Install Scala & SBT & Rust
RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C $SCALA_HOME --strip-components 1
RUN curl -fsL https://piccolo.link/sbt-${SBT_VERSION}.tgz | tar xfz - -C $SBT_HOME  --strip-components 1
RUN apk add --no-cache cargo

# Define working directory
WORKDIR /root
