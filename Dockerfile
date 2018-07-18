
FROM golang:1.9 AS builder

WORKDIR /go/src/github.com/bitly/oauth2_proxy
COPY . /go/src/github.com/bitly/oauth2_proxy/
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .

FROM gliderlabs/alpine:latest

RUN apk-install ca-certificates
WORKDIR /
COPY --from=builder /go/src/github.com/bitly/oauth2_proxy/oauth2_proxy /usr/local/bin/oauth2_proxy

ENTRYPOINT ["oauth2_proxy"]
CMD ["--help"]
