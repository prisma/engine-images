# Prisma Images

This repo contains all custom images used to build and run Prisma.

## Images
- **Legacy build image**: Used before the transition to the native image.
- **Prisma build image debian**: Current build image containing Rust and Graal runtimes for compilation. Based on debian.
- **Prisma runtime image graal**: Large runtime image that uses GraalVM instead of the JVM like we do on the apapsix java alpine image.

## How to build
- CD into the folder you want to build.
- `make build` builds the image locally.
- `make push` pushes the image to DockerHub.
- Note: You require the appropriate DockerHub rights to push.
- Note: Pushing to master triggers a CI build that releases new images.
- **Note: The legacy build image is not build on CI**