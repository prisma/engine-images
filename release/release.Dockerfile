FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y gnupg2 curl wget pkg-config build-essential git zlib1g-dev libssl-dev libkrb5-dev libgss-dev libclang-dev

# Prisma public key. Command also sets up the folders used by GnuPG.
RUN gpg --keyserver keys.openpgp.org --recv-keys C50CDE3D01071B0AFDBB11753E23AF055A551BDB
RUN bash -c "echo 'allow-loopback-pinentry' > /root/.gnupg/gpg-agent.conf"
