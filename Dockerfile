FROM nextcloud:25.0.4-apache

LABEL description="apache with nextcloud, logrotate and supervisord" \
      maintainer="merzi"

RUN apt-get update && apt-get dist-upgrade -y \
    && apt-get install -y supervisor logrotate procps smbclient \
    && apt-get install -y --no-install-recommends libmagickcore-6.q16-6-extra \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/debconf/*-old \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY configs/supervisord.conf /

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
