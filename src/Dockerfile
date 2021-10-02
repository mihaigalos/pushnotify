FROM debian:buster-slim
RUN apt-get update \
    && apt-get install -y \
        curl \
        sudo \
        systemd

WORKDIR "/src"
ENTRYPOINT ["/src/run.sh"]
