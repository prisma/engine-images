FROM alpine:3.8

# Env variables
ENV GRAAL_HOME /graalvm/Contents/Home
ENV JAVA_HOME /graalvm/Contents/Home
ENV PATH ${GRAAL_HOME}/bin:${SCALA_HOME}/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/lib:/lib

RUN apk add --no-cache curl bash ca-certificates libgcc
RUN mkdir -p $GRAAL_HOME
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk
RUN apk add glibc-2.28-r0.apk

# Install graal
RUN \
  curl -L --output graal.tar.gz https://github.com/oracle/graal/releases/download/vm-1.0.0-rc10/graalvm-ce-1.0.0-rc10-linux-amd64.tar.gz && \
  tar xzf graal.tar.gz -C ${GRAAL_HOME} --strip-components 1 && \
  rm -rf graal.tar.gz

# Install Scala & SBT & Rust
# RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C $SCALA_HOME --strip-components 1
# RUN curl -fsL https://piccolo.link/sbt-${SBT_VERSION}.tgz | tar xfz - -C $SBT_HOME  --strip-components 1
# RUN apk add --no-cache cargo

# SBT doesn't handle env vars properly, so just link it on the default path
# RUN ln -s ~/.cargo/bin/* /usr/bin/  

# Change default shell
# RUN sed -i 's~:/bin/ash$~:/bin/bash~' /etc/passwd

# Define working directory
WORKDIR /root
