# Builder
FROM golang:1.10 as builder
# RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

WORKDIR /go/src/github.com/rjsheperd/oodie
COPY vendor /go/src/

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o oodie .

# Server
FROM alpine:latest
# FROM resin/%%RESIN_MACHINE_NAME%%-golang:1.10-slim
RUN apk --no-cache add ca-certificates

WORKDIR /app

COPY --from=builder /go/src/github.com/rjsheperd/oodie/oodie .
COPY start.sh .

# Enable systemd init system in container
# ENV INITSYSTEM on

# Run the start script
CMD ["sh", "/app/start.sh"]
