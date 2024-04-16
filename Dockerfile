FROM maven:3.8.4-openjdk-17 AS build
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn package

FROM adoptopenjdk/openjdk17:alpine-jre
COPY --from=build /usr/src/app/target/my-app.jar /usr/app/my-app.jar
ENTRYPOINT ["java", "-jar", "/usr/app/my-app.jar"]

