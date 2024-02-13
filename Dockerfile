FROM openjdk:21
COPY "gradle/wrapper"/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]