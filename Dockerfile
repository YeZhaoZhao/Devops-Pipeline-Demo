FROM golang:1.22-alpine AS builder

WORKDIR /src

COPY go.mod ./
RUN go mod download

COPY main.go ./
RUN CGO_ENABLED=0 go build -ldflags "-s -w" -o /out/app .

FROM alpine:3.20

WORKDIR /app
COPY --from=builder /out/app .

EXPOSE 8080

CMD ["/app/app"]
