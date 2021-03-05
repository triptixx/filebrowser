ARG ALPINE_TAG=3.13
ARG FILEBROWSER_VER=2.12.0

FROM node:alpine AS builder_frontend

ARG FILEBROWSER_VER

### install frontend
WORKDIR /frontend-src
RUN apk add --no-cache git; \
    git clone https://github.com/filebrowser/filebrowser.git --branch v${FILEBROWSER_VER} --depth 1 .; \
    cd frontend; \
    npm install; \
    npm run build; \
    npm prune --production; \
    find ./node_modules/* -name 'node_modules' -type d -prune -print -exec rm -rf '{}' \;

#============================================================

FROM golang:alpine AS builder_backend

COPY --from=builder_frontend /frontend-src/ /backend-src/

### install backend
WORKDIR /backend-src
RUN apk add --no-cache git upx; \
    go get github.com/GeertJohan/go.rice/rice; \
    go mod download; \
    cd http; \
    rice embed-go; \
    cd ..; \
    go build -ldflags="-s -w" -o /output/filebrowser/filebrowser; \
    upx --brute /output/filebrowser/filebrowser

COPY *.sh /output/usr/local/bin/
RUN chmod +x /output/usr/local/bin/*.sh

#============================================================

FROM loxoo/alpine:${ALPINE_TAG}

ARG FILEBROWSER_VER
ENV SUID=953 SGID=900

LABEL org.label-schema.name="filebrowser" \
      org.label-schema.description="A Docker image for Web File Browser app" \
      org.label-schema.url="https://filebrowser.xyz" \
      org.label-schema.version=${FILEBROWSER_VER}

COPY --from=builder_backend /output/ /

WORKDIR /filebrowser

VOLUME ["/data"]

EXPOSE 8080/TCP

HEALTHCHECK --start-period=10s --timeout=5s \
    CMD wget -qO /dev/null "http://localhost:8080/login"

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["/filebrowser/filebrowser", "-c", "/config/filebrowser.json"]
