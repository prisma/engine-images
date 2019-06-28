FROM lambci/lambda:build-go1.x

ENV PATH /root/.cargo/bin:$PATH
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/include/linux
ENV RUST_BACKTRACE=1

RUN mv /usr/bin/openssl /usr/bin/openssl_old

# Lock specific openssl version
RUN \
  curl -L --output openssl.tar.gz https://www.openssl.org/source/openssl-1.0.2s.tar.gz && \
  tar xzf openssl.tar.gz && \
  rm -rf openssl.tar.gz && \
  cd openssl-1.0.2s && \
  ./config && \
  make && \
  make install

# && \
# ln -s /usr/local/lib64/libssl.so.10 /usr/lib64/ && \
# ln -s /usr/local/lib64/libcrypto.so.10 /usr/lib64/ && \


#&& \
# ln -s /usr/local/bin/openssl /usr/bin/openssl

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y