FROM maven:latest as build-env
WORKDIR /app/organizer
ADD ./apps/organizer /app/organizer
ADD ./apis /apis
RUN mvn clean compile package

FROM gcr.io/distroless/java
COPY --from=build-env /app/organizer/target/organizer-1.0-SNAPSHOT-jar-with-dependencies.jar /
CMD ["./organizer-1.0-SNAPSHOT-jar-with-dependencies.jar"]
