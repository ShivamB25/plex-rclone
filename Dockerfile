FROM lscr.io/linuxserver/plex

RUN apt-get update && \
    apt-get install -y curl unzip wget fuse3 && \
    apt-get clean

RUN curl https://rclone.org/install.sh | bash

COPY rclone.conf /root/.config/rclone/rclone.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /config
VOLUME /transcode
VOLUME /data

EXPOSE 32400

ENTRYPOINT ["/entrypoint.sh"]
