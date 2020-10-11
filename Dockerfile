FROM alpine:latest
ENV CONFIG_JSON=none CERT_PEM=none KEY_PEM=none VER=4.3
RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && mkdir -m 777 /v2ray \
 && mkdir -p /var/log/v2ray \
 && cd /v2ray \
 && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
 && unzip v2ray.zip \
 && chmod +x /v2ray/v2ray \
 && chmod +x /v2ray/v2ctl \
 && rm -rf v2ray.zip \
 && chgrp -R 0 /v2ray \
 && chmod -R g+rwX /v2ray
ADD config.json /v2ray/config.json
EXPOSE 443
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT  /entrypoint.sh
