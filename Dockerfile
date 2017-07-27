FROM golang:1.8
MAINTAINER  Yaroslav Molochko <y.molochko@anchorfree.com>

COPY . /go/src/github.com/anchorfree/nginx_exporter
RUN go get github.com/prometheus/log \
    && go get github.com/prometheus/client_golang/prometheus \
    && CGO_ENABLED=0 go build -a -tags netgo -o /build/nginx_exporter github.com/anchorfree/nginx_exporter

FROM alpine
COPY --from=0 /build/nginx_exporter /
EXPOSE 9113
ENTRYPOINT ["/nginx_exporter"]
