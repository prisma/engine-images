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

# Define working directory
WORKDIR /root
