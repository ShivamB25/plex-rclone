#!/bin/bash

# Start Rclone mount in the background
rclone mount --allow-non-empty --allow-other --dir-cache-time 96h --drive-chunk-size 32M --timeout 1h --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit off gdrive: /data &

# Wait for Rclone to mount
while ! mountpoint -q /data; do
  echo "Waiting for Rclone mount..."
  sleep 1
done

echo "Rclone mount is ready."

# Start Plex
exec /init
