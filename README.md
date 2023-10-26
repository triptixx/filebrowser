[hub]: https://hub.docker.com/r/loxoo/filebrowser
[git]: https://github.com/triptixx/filebrowser/tree/master
[actions]: https://github.com/triptixx/filebrowser/actions/workflows/main.yml

# [loxoo/filebrowser][hub]
[![Git Commit](https://img.shields.io/github/last-commit/triptixx/filebrowser/master)][git]
[![Build Status](https://github.com/triptixx/filebrowser/actions/workflows/main.yml/badge.svg?branch=master)][actions]
[![Latest Version](https://img.shields.io/docker/v/loxoo/filebrowser/latest)][hub]
[![Size](https://img.shields.io/docker/image-size/loxoo/filebrowser/latest)][hub]
[![Docker Stars](https://img.shields.io/docker/stars/loxoo/filebrowser.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/loxoo/filebrowser.svg)][hub]

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