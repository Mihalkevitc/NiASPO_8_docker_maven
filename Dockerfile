# Используем базовый образ OpenJDK 17 на Alpine Linux
FROM openjdk:17-alpine AS build

# Копируем исходный код в рабочую директорию контейнера
COPY . /usr/src/app

# Устанавливаем рабочую директорию
WORKDIR /usr/src/app

# Собираем приложение с помощью Maven
RUN apk add --no-cache maven
RUN mvn clean package

# Отдельный этап для запуска приложения
FROM openjdk:17-alpine

# Копируем JAR файл из предыдущего этапа
COPY --from=build /usr/src/app/target/my-app.jar /usr/app/my-app.jar

# Указываем точку входа для запуска приложения
ENTRYPOINT ["java", "-jar", "/usr/app/my-app.jar"]

