FROM python:3-slim AS build-env
WORKDIR /app/participant
ADD . /app/participant

FROM gcr.io/distroless/python3
COPY --from=build-env /app/participant /app
WORKDIR /app
CMD ["main.py"]
