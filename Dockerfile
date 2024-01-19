FROM adoptopenjdk/openjdk11:jre

ARG POWER_TUNNEL_RELEASE
VOLUME /config

WORKDIR /opt

COPY entry.sh .

RUN apt-get -q update \
    && apt-get -q install wget ca-certificates -y \
    && wget -nv https://github.com/krlvm/PowerTunnel/releases/download/${POWER_TUNNEL_RELEASE}/PowerTunnel.jar \
    && chmod +x ./entry.sh

ENTRYPOINT [ "./entry.sh" ]