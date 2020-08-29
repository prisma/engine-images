FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y gnupg2 curl wget pkg-config build-essential git zlib1g-dev libssl-dev libkrb5-dev libgss-dev libclang-dev

# Prisma public key. Command also sets up the folders used by GnuPG.
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 000C7F56AFE666523AC8C694D2CF263D3EA15090
RUN bash -c "echo 'allow-loopback-pinentry' > /root/.gnupg/gpg-agent.conf"
