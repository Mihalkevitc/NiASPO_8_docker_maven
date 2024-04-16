FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY . /app
RUN mvn -B -DskipTests clean package

FROM adoptopenjdk/openjdk17:jdk-17.0.2_8-alpine
WORKDIR /app
COPY --from=build /app/target/docker_maven-1.0-SNAPSHOT.jar /app/app.jar
CMD ["java", "-jar", "app.jar"]
