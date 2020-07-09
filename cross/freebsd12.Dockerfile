FROM debian:10-slim AS build

RUN mkdir /freebsd

WORKDIR /freebsd

RUN apt-get -y update && \
    apt-get -y install build-essential m4 bison flex libtool automake autoconf autogen pkg-config curl

RUN curl -OL "http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/12.1-RELEASE/base.txz"
RUN curl -OL "http://ftp.swin.edu.au/gnu/binutils/binutils-2.32.tar.xz"
RUN curl -OL "http://ftp.swin.edu.au/gnu/gmp/gmp-6.1.2.tar.xz"
RUN curl -OL "http://ftp.swin.edu.au/gnu/mpfr/mpfr-4.0.2.tar.xz"
RUN curl -OL "http://ftp.swin.edu.au/gnu/mpc/mpc-1.1.0.tar.gz"
RUN curl -OL "http://ftp.swin.edu.au/gnu/gcc/gcc-6.4.0/gcc-6.4.0.tar.xz"

RUN mkdir -p /src/base /freebsd/x86_64-pc-freebsd12 && \
    tar -C /src/base -Jxf base.txz

# Populate the path that gcc will look in for headers and libs
RUN mv /src/base/usr/include /freebsd/x86_64-pc-freebsd12 && \
    mv /src/base/usr/lib /freebsd/x86_64-pc-freebsd12 && \
    mv /src/base/lib/* /freebsd/x86_64-pc-freebsd12/lib

# These libraries are actually linker scripts (grep -lr ldscript usr)
# https://sourceware.org/binutils/docs/ld/Scripts.html
# Adjust the paths to match their new locations
RUN sed -i'' \
    -e "s!/usr/lib/!/freebsd/x86_64-pc-freebsd12/lib/!g" \
    -e "s!/lib/libc.so.7!/freebsd/x86_64-pc-freebsd12/lib/libc.so.7!g" \
    -e "s!/lib/libc.so.6!/freebsd/x86_64-pc-freebsd12/lib/libc.so.6!g" \
    /freebsd/x86_64-pc-freebsd12/lib/libc.so && \
    sed -i'' \
    "s!/usr/lib/!/freebsd/x86_64-pc-freebsd12/lib/!g" \
    /freebsd/x86_64-pc-freebsd12/lib/libc++.so

# Fix symlinks broken by moving libraries
COPY fix-links /src
RUN /src/fix-links /freebsd/x86_64-pc-freebsd12/lib

RUN tar -C /src -Jxf binutils-2.32.tar.xz && \
    tar -C /src -Jxf gcc-6.4.0.tar.xz && \
    tar -C /src -Jxf gmp-6.1.2.tar.xz && \
    tar -C /src -zxf mpc-1.1.0.tar.gz && \
    tar -C /src -Jxf mpfr-4.0.2.tar.xz

## Build toolchain

# Binutils
RUN cd /src/binutils-2.32 && \
    ./configure --enable-libssp --enable-ld --target=x86_64-pc-freebsd12 --prefix=/freebsd && \
    make -j7 && \
    make install

# GMP
RUN cd /src/gmp-6.1.2 && \
    ./configure --prefix=/freebsd --enable-shared --enable-static \
    --enable-mpbsd --enable-fft --enable-cxx --host=x86_64-pc-freebsd12 && \
    make -j7 && \
    make install

# MPFR
RUN cd /src/mpfr-4.0.2 && \
    ./configure --prefix=/freebsd --with-gnu-ld --enable-static \
    --enable-shared --with-gmp=/freebsd --host=x86_64-pc-freebsd12 && \
    make -j7 && \
    make install

# MPC
RUN cd /src/mpc-1.1.0/ && \
    ./configure --prefix=/freebsd --with-gnu-ld \
    --enable-static --enable-shared --with-gmp=/freebsd \
    --with-mpfr=/freebsd --host=x86_64-pc-freebsd12 &&\
    make -j7 && \
    make install

# GCC
RUN mkdir -p /src/gcc-6.4.0/build && \
    cd /src/gcc-6.4.0/build && \
    ../configure --without-headers --with-gnu-as --with-gnu-ld --disable-nls \
    --enable-languages=c,c++ --enable-libssp --enable-ld \
    --disable-libitm --disable-libquadmath --target=x86_64-pc-freebsd12 \
    --prefix=/freebsd --with-gmp=/freebsd \
    --with-mpc=/freebsd --with-mpfr=/freebsd --disable-libgomp && \
    LD_LIBRARY_PATH=/freebsd/lib make -j7 && \
    make install

# Now copy the toolchain to a fresh image
FROM debian:10-slim

COPY --from=build /freebsd /freebsd

ENV LD_LIBRARY_PATH /freebsd/lib:/lib:/usr/lib:/usr/include/linux:/lib/x86_64-linux-gnu
ENV PATH /freebsd/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.cargo/bin:$PATH
ENV CC x86_64-pc-freebsd12-gcc
ENV CPP x86_64-pc-freebsd12-cpp
ENV AS x86_64-pc-freebsd12-as
ENV LD x86_64-pc-freebsd12-ld
ENV AR x86_64-pc-freebsd12-ar
ENV RANLIB x86_64-pc-freebsd12-ranlib
ENV HOST x86_64-pc-freebsd12
ENV OPENSSL_DIR /freebsd/x86_64-pc-freebsd12/

RUN apt-get update && apt-get -y install wget curl git make build-essential libz-dev libsqlite3-dev openssl libssl-dev pkg-config gzip mingw-w64 g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev
RUN apt-get -y install freebsd-buildutils
RUN apt-get -y install flex

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup target add x86_64-unknown-freebsd
RUN echo "[target.x86_64-unknown-freebsd]" >> ~/.cargo/config
RUN echo "linker = \"x86_64-pc-freebsd12-gcc\"" >> ~/.cargo/config
