FROM python:3 AS build-env
WORKDIR /app/participant
ADD . /app/participant
RUN pip3 install -r ./requirements.txt

FROM gcr.io/distroless/python3
COPY --from=build-env /app/participant /app
COPY --from=build-env /usr/local/lib/python3.5/site-packages /usr/local/lib/python3.5/site-packages

WORKDIR /app
ENV PYTHONPATH=/usr/local/lib/python3.5/site-packages
CMD ["main.py"]
