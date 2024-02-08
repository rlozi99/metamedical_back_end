FROM openjdk:21
VOLUME /tmp
ARG JAR_FILE_PATH=target/*.jar
COPY target/*.jar gradle-wrapper.jar
ENTRYPOINT ["java","-jar","/app.jar"]