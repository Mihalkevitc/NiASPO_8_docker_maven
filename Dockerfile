# Используем базовый образ Maven для сборки проекта
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . /app
RUN mvn -B -DskipTests clean package

# Используем образ с Java Runtime для запуска приложения
FROM openjdk:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/docker_maven-1.0-SNAPSHOT.jar /app/app.jar
CMD ["java", "-jar", "app.jar"]
