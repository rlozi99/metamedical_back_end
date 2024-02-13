FROM openjdk:11
COPY "gradle/wrapper"/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]