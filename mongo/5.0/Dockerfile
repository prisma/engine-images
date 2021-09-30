FROM mongo:5.0.3
COPY docker-entrypoint.sh /usr/local/bin/
RUN openssl rand -base64 756 > /security.keyFile
RUN chmod 400 /security.keyFile
RUN chown mongodb:mongodb /security.keyFile
RUN chmod +x /usr/local/bin/docker-entrypoint.sh