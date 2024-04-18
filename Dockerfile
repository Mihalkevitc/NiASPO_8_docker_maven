# Используем базовый образ Maven для сборки проекта
FROM openjdk:11

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_VERSION 3.8.2
ENV PATH $MAVEN_HOME/bin:$PATH

# Выводим содержимое рабочей директории для отладки
RUN apt-get update \
    && apt-get install -y maven \
    && rm -rf /var/lib/apt/lists/*

# Копируем исходный код в рабочую директорию контейнера
COPY . /usr/src/app

# Устанавливаем рабочую директорию
WORKDIR /usr/src/app



# Собираем приложение с помощью Maven
RUN mvn clean install

CMD ["java", "-jar", "target/docker_maven-1.0-SNAPSHOT.jar"]
