FROM lambci/lambda:build-go1.x

ENV PATH /root/.cargo/bin:$PATH
# ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/include/linux
ENV RUST_BACKTRACE=1

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup install beta && rustup default beta