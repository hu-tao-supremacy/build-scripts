FROM maven:latest as build-env
WORKDIR /app/organizer
ADD . /app/organizer
RUN mvn clean install

FROM gcr.io/distroless/java
COPY --from=build-env /app/organizer/target/organizer-app.jar /
CMD ["./organizer-app.jar"]
