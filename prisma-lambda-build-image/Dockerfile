FROM lambci/lambda:build-go1.x

ENV SCALA_VERSION 2.12.3
ENV SBT_VERSION 1.2.3
ENV GRAAL_HOME /graalvm/Contents/Home
ENV JAVA_HOME /graalvm/Contents/Home
ENV SBT_HOME /usr/local/sbt
ENV SCALA_HOME /usr/local/scala
ENV PATH ${GRAAL_HOME}/bin:${SCALA_HOME}/bin:${SBT_HOME}/bin:/root/.cargo/bin:$PATH
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/root/build/libs/jwt-native/src/main/resources:/usr/include/linux
ENV RUST_BACKTRACE=1

RUN mkdir -p $GRAAL_HOME
RUN mkdir -p $SCALA_HOME
RUN mkdir -p $SBT_HOME

# Update OpenSSL
RUN \
  curl -L --output openssl.tar.gz https://www.openssl.org/source/openssl-1.1.1a.tar.gz && \
  tar xzf openssl.tar.gz && \
  rm -rf openssl.tar.gz && \
  cd openssl-1.1.1a && \
  ./config && \
  make && \
  make install && \
  ln -s /usr/local/lib64/libssl.so.1.1 /usr/lib64/ && \
  ln -s /usr/local/lib64/libcrypto.so.1.1 /usr/lib64/ && \
  mv /usr/bin/openssl /usr/bin/openssl_old && \
  ln -s /usr/local/bin/openssl /usr/bin/openssl

# Install graal
RUN \
  curl -L --output graal.tar.gz https://github.com/oracle/graal/releases/download/vm-1.0.0-rc10/graalvm-ce-1.0.0-rc10-linux-amd64.tar.gz && \
  tar xzf graal.tar.gz -C ${GRAAL_HOME} --strip-components 1 && \
  rm -rf graal.tar.gz

# Install Scala & SBT & Rust
RUN curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C $SCALA_HOME --strip-components 1
RUN curl -fsL https://piccolo.link/sbt-${SBT_VERSION}.tgz | tar xfz - -C $SBT_HOME  --strip-components 1
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y