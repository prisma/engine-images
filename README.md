# Prisma Images

This repo contains all build images for the [Prisma engines](https://github.com/prisma/prisma-engine).
Images are based on the requirements of the ["Binaries" spec](https://github.com/prisma/specs/blob/master/binaries/Readme.md).

Images are based on the lowest common denominator of glibc and OpenSSL. In practice, this means:
- OpenSSL variants 1.0.1 and 1.1.0: OpenSSL is forwards, but not backwards compatible. For example, 1.0.1 works with 1.0.2, but not vice versa.
- We use the lowest image of an OS that we want to support (e.g. jessie for Debian) due to glibc restrictions. As with OpenSSL, glibc is forwards, but not backwards compatible.
- On the lowest image mentioned above, we install OpenSSL either manually or via package manager, whichever is fitting.

## Images
- **Debian**: Debian-based build images for OpenSSL 1.0.1 and 1.1.0 and glibc 2.19. Usable for all debian derivatives (Ubuntu, Mint, etc.) and Arch Linux.
- **RHEL**: CentOS-based build images for OpenSSL 1.0.1 and 1.1.0 and glibc 2.19. Usable for all RHEL derivatives (RedHat, CentOS, Amazon Linux, etc.).
- **Cross**: Cross compilation image, currently for Windows MSVC cross compilation.

## How to build
- CD into the folder you want to build.
- `make build` builds the image(s) locally.
- `make push` pushes the image(s) to DockerHub.
- Notes:
  - You require the appropriate DockerHub rights to push.
  - Pushing to master triggers a CI build that releases new images.
