FROM maven:3.9.0-eclipse-temurin-17

WORKDIR /usr/src/app

# Копируем Maven wrapper, pom.xml и проект
COPY . .

# Делаем скрипты исполняемыми
RUN chmod +x scripts/*.sh

# Установка psql
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*

# По умолчанию можно собрать jar без запуска тестов (для проверки сборки)
RUN mvn clean package -DskipTests

# По умолчанию контейнер просто готов к запуску тестов
CMD ["mvn", "test"]
