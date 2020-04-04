[hub]: https://hub.docker.com/r/loxoo/filebrowser
[mbdg]: https://microbadger.com/images/loxoo/filebrowser
[git]: https://github.com/triptixx/filebrowser
[actions]: https://github.com/triptixx/filebrowser/actions

# [loxoo/filebrowser][hub]
[![Layers](https://images.microbadger.com/badges/image/loxoo/filebrowser.svg)][mbdg]
[![Latest Version](https://images.microbadger.com/badges/version/loxoo/filebrowser.svg)][hub]
[![Git Commit](https://images.microbadger.com/badges/commit/loxoo/filebrowser.svg)][git]
[![Docker Stars](https://img.shields.io/docker/stars/loxoo/filebrowser.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/loxoo/filebrowser.svg)][hub]
[![Build Status](https://github.com/triptixx/filebrowser/workflows/docker%20build/badge.svg)][actions]

## Usage

```shell
docker run -d \
    --name=srvfilebrowser \
    --restart=unless-stopped \
    --hostname=srvfilebrowser \
    -p 8080:8080 \
    -e ROOT_DIR=/srv \
    -v $PWD/data:/data \
    -v $PWD/srv:/srv \
    loxoo/filebrowser
```

## Environment

- `$SUID`                - User ID to run as. _default: `953`_
- `$SGID`                - Group ID to run as. _default: `900`_
- `$ROOT_DIR`            - Root to prepend to relative paths. _default: `.`_
- `$TZ`                  - Timezone. _optional_

## Volume

- `/data`                - Database path.

## Network

- `8080/tcp`             - Port to listen on.