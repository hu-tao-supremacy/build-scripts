FROM maven:latest as build-env
WORKDIR /app/organizer
ADD . /app/organizer
RUN mvn clean compile package

FROM gcr.io/distroless/java
COPY --from=build-env /app/organizer/target/organizer-1.0-SNAPSHOT.jar /
CMD ["./organizer-1.0-SNAPSHOT.jar"]
