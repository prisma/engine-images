OUTPUT = /opt/cross

GCC_VER = 11.2.0

# This should match the musl version that the Rust compiler uses.
# See https://github.com/rust-lang/rust/blob/master/src/ci/docker/scripts/musl-toolchain.sh
#
# It isn't updated often (last time it was updated to 1.2.3 in Rust
# 1.71, before that it was 1.1.24 since Rust 1.46), and it is
# announced in the release notes when it's updated.
MUSL_VER = 1.2.3

DL_CMD = curl -C - -L -o

# Recommended options for smaller build for deploying binaries.
COMMON_CONFIG += CFLAGS="-g0 -Os -w" CXXFLAGS="-g0 -Os -w" LDFLAGS="-s"

# Disable gcc features we don't need for a smaller and faster build.
COMMON_CONFIG += --disable-nls
GCC_CONFIG += --enable-languages=c,c++
GCC_CONFIG += --disable-libquadmath --disable-decimal-float
GCC_CONFIG += --disable-multilib

# Tell gdb where to look for source files.
COMMON_CONFIG += --with-debug-prefix-map=$(CURDIR)=
