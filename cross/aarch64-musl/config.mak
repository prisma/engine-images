OUTPUT = /opt/cross

GCC_VER = 11.2.0

# This should match the musl version that the Rust compiler uses.
# It isn't updated often (last time it was updated to 1.2.3 in Rust 1.71,
# before that it was 1.1.24 since Rust 1.46).
MUSL_VER = 1.2.3

DL_CMD = curl -C - -L -o

COMMON_CONFIG += CFLAGS="-g0 -Os -w" CXXFLAGS="-g0 -Os -w" LDFLAGS="-s"
COMMON_CONFIG += --disable-nls
COMMON_CONFIG += --with-debug-prefix-map=$(CURDIR)=

GCC_CONFIG += --enable-languages=c,c++
GCC_CONFIG += --disable-libquadmath --disable-decimal-float
GCC_CONFIG += --disable-multilib
