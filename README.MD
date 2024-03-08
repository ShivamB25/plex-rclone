# Plex with rclone Mount

This Docker image runs [Plex Media Server](https://www.plex.tv/) with an [rclone](https://rclone.org/) mount to serve media files from a cloud storage provider.

## How it works

Docker rclone

The entrypoint script launches rclone in the background to mount the configured remote storage to the `/data` directory inside the container. It then waits for the mount to be ready before starting Plex.

Plex will then serve media files from the rclone mount at `/data` as if they were local files. This allows streaming your media library from a cloud storage provider directly through Plex.

## Usage

### Prerequisites

- A supported cloud storage provider configured with rclone (see [rclone docs](https://rclone.org/docs/) for setup instructions)
- `docker` and `docker-compose` installed on your host

### Configuration

1. Clone this repository and cd into it:

   ```bash
   git clone https://github.com/myusername/plex-rclone.git
   cd plex-rclone
   ```

2. Create an `rclone.conf` file with the configuration for your cloud storage remote (see [rclone docs](https://rclone.org/docs/) for help).

3. Update the `docker-compose.yml` file with your desired configuration:

   ```yaml
   version: '3'
   services:
     plex:
       image: myusername/plex-rclone
       container_name: plex
       environment:
         - PUID=1000
         - PGID=1000
         - TZ=Europe/London 
       volumes:
         - /path/to/config:/config
         - /path/to/transcode:/transcode
       ports:
         - 32400:32400
       restart: unless-stopped
   ```

   - Set the `PUID` and `PGID` to match your user/group IDs on the host
   - Configure volumes for Plex config and transcode directories
   - Adjust published ports as needed

4. Enable FUSE on the host if not already enabled:

   ```bash 
   sudo modprobe fuse
   ```

### Running

Start the container with:

```bash
docker-compose up -d  
```

Plex will now be accessible at `http://localhost:32400/web`.

## Building

To build the image yourself:

```bash
docker build -t myusername/plex-rclone .
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [linuxserver/plex](https://github.com/linuxserver/docker-plex) - Base Plex Docker image
- [rclone](https://rclone.org/) - Awesome cloud storage mount tool

