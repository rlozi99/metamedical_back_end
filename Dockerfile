# Build Stage
FROM openjdk:21 AS build
WORKDIR /app
COPY . .
RUN ./gradlew build

FROM openjdk:21
WORKDIR /app
COPY build/libs/demo-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]