FROM openjdk:21
WORKDIR /usr/src/app
COPY . /app
RUN command_to_install_dependencies
CMD ["java", "-jar", "run", "/app.jar"]