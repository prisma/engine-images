# Prisma Engine Images
[![Build status](https://badge.buildkite.com/e1edf477cecc77e01d2eff2cc64edc5bfd07db651fe602f8b6.svg)](https://buildkite.com/prisma/prisma-engine-images)

This repo contains all build and test images, as well as a few customized database images, for the [Prisma engines](https://github.com/prisma/prisma-engine).

Images are based on the lowest common denominator of glibc and OpenSSL. In practice, this means:
- OpenSSL variants 1.0.1 and 1.1.0: OpenSSL is forwards, but not backwards compatible. For example, 1.0.1 works with 1.0.2, but not vice versa.
- We use the lowest image of an OS that we want to support (e.g. jessie for Debian) due to glibc restrictions. As with OpenSSL, glibc is forwards, but not backwards compatible.
- On the lowest image mentioned above, we install OpenSSL either manually or via package manager, whichever is fitting, then compile to get the binary for the target combination.

## Images

### Build
- **RHEL**: CentOS-based build images for OpenSSL 1.0.1 and 1.1.0 and glibc 2.19. Usable for all linux distros with at least the given glibc version (RedHat, CentOS, Amazon Linux, Debian, Ubuntu, Arch Linux, etc.).
- **Cross**: Cross compilation images, currently for Windows GNU, MacOS and Linux ARM cross compilation.
- **Test**: Test base image for CI. Contains all dependencies to run the connector test kit and cargo tests.
- **Release**: Debian-based (Bullseye) image responsible for computing checksums and GPG signatures as part of the Prisma release process.
- **Musl**: TODO

### Databases
- **SQL Server** - SQL Server with small modification to speed up tests
- **MongoDB** - MongoDB configured as a single replica setup
- **CockroachDB** - CockroachDB configured in a way so that it is less slow

## How to build the images
- CD into the folder you want to build.
- `make build` builds the image(s) locally.
- `make push` pushes the image(s) to DockerHub (requires access, of course).

## Automatic image releases
- Git pushing to main triggers a CI build that releases new images.
- All images are pushed to `prismagraphql/build:<tag>`. Check the different Makefiles for the exact tags getting pushed.
- **Important note**: Images can be read publicly. Do not commit secrets into the containers; do not push anything confidential into the repository.

## Credits
- Credit to https://wapl.es/rust/2019/02/17/rust-cross-compile-linux-to-macos.html for the work that the MacOS cross compilation image is based on.
