FROM debian:buster-slim

RUN apt-get update \
    && apt-get install -y \
        curl \
        sudo \
        systemd

ADD . /src
WORKDIR "/src"

ENTRYPOINT ["/src/push.sh"]
