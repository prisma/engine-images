# Allows us using tmpfs on the mssql image, speeding up the tests.
FROM mcr.microsoft.com/mssql/server:2017-latest
ADD nodirect_open.c /
RUN apt update && apt install -y gcc && \
gcc -shared -fpic -o /nodirect_open.so nodirect_open.c -ldl && \
apt purge -y gcc && \
echo "/nodirect_open.so" >> /etc/ld.so.preload
