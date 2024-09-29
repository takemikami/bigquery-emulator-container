FROM ghcr.io/goccy/bigquery-emulator:latest

COPY entrypoint.sh /bin/entrypoint.sh

RUN chmod +x /bin/entrypoint.sh

WORKDIR /work

ENTRYPOINT ["/bin/entrypoint.sh"]
