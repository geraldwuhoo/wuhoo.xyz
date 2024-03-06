FROM registry.gitlab.com/pages/hugo:0.119.0 AS build

RUN apk add --update --no-cache git go

COPY . /site
WORKDIR /site

RUN hugo --minify --enableGitInfo

FROM docker.io/p3terx/darkhttpd:1.16

WORKDIR /public

COPY --from=build /site/public /public

EXPOSE 80

CMD ["/public"]
