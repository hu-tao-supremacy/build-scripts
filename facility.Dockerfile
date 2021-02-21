FROM golang:latest as build-env
WORKDIR /app/facility
ADD . /app/facility
RUN go build -o main ./cmd/*.go

FROM gcr.io/distroless/base
COPY --from=build-env /app/facility/main /
EXPOSE 50051
CMD ["./main"]
