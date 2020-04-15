FROM golang:1.14 as build-env

ADD . /go/src/github.com/a1comms/gcs-tftp-server
WORKDIR /go/src/github.com/a1comms/gcs-tftp-server

ARG CGO_ENABLED=0

RUN go mod vendor
RUN go build -ldflags "-s -w" -o /go/bin/app

FROM gcr.io/distroless/static
COPY --from=build-env /go/bin/app /
CMD ["/app"]
