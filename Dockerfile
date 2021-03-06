FROM registry.gitlab.com/pages/hugo:0.101.0 AS build

RUN apk add --update --no-cache git go

COPY . /site
WORKDIR /site

RUN hugo --minify --enableGitInfo

FROM docker.io/joseluisq/static-web-server:2.10.0

ENV SERVER_ROOT=/public
WORKDIR /public

COPY --from=build /site/public /public
