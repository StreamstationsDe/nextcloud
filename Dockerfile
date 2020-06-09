FROM nextcloud:apache

LABEL description="apache with nextcloud, logrotate and supervisord" \
      maintainer="merzi"

RUN apt-get update && apt-get install -y \
    supervisor logrotate \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY configs/supervisord.conf /

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]