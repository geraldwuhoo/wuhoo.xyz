FROM docker.io/library/golang:1.18-alpine3.16 AS build

ARG VERSION=0.100.1

WORKDIR /
ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz /hugo.tar.gz
RUN tar -zxvf hugo.tar.gz && \
    /hugo version

RUN apk add --no-cache git

COPY . /site
WORKDIR /site

RUN /hugo --minify --enableGitInfo

FROM docker.io/joseluisq/static-web-server:2.9.0

ENV SERVER_ROOT=/public
WORKDIR /public

COPY --from=build /site/public /public
