# Используем базовый образ Maven для сборки проекта
FROM maven:3.8.4-openjdk-17 AS build

# Копируем исходный код в рабочую директорию контейнера
COPY ./src /usr/src/app/src
COPY ./pom.xml /usr/src/app/pom.xml

# Устанавливаем рабочую директорию
WORKDIR /usr/src/app

# Собираем приложение с помощью Maven
RUN mvn clean package

# Отдельный этап для запуска приложения
FROM adoptopenjdk/openjdk17:alpine-jre

# Копируем JAR файл из предыдущего этапа
COPY --from=build /usr/src/app/target/my-app.jar /usr/app/my-app.jar

# Указываем точку входа для запуска приложения
ENTRYPOINT ["java", "-jar", "/usr/app/my-app.jar"]
