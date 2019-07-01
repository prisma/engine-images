# Prisma Images

This repo contains all custom images used to build and run Prisma.

## Images
- **Legacy build image**: Used before the transition to the native image.
- **Prisma build image debian**: Current build image containing Rust and Graal runtimes for compilation. Based on debian.
- **Prisma runtime image graal**: Large runtime image that uses GraalVM instead of the JVM like we do on the apapsix java alpine image. DEPRECATED.
- **Prisma rust image**: Slim build image for our Rust code.

## How to build
- CD into the folder you want to build.
- `make build` builds the image locally.
- `make push` pushes the image to DockerHub.
- Note: You require the appropriate DockerHub rights to push.
- Note: Pushing to master triggers a CI build that releases new images.
- **Note: The legacy build image is not build on CI**

## Important Notes
- If you want to convince CI to take your newly build images, bump your image version in the Makefiles (including the tag). Then update the build cli to take your new image tag.