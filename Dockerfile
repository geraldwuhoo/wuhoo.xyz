FROM registry.gitlab.com/pages/hugo:0.104.1 AS build

RUN apk add --update --no-cache git go

COPY . /site
WORKDIR /site

RUN hugo --minify --enableGitInfo

FROM docker.io/joseluisq/static-web-server:2.12.0

ENV SERVER_ROOT=/public
WORKDIR /public

COPY --from=build /site/public /public
