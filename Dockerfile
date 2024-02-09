# Use the official OpenJDK base image
FROM openjdk:21

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file into the container at /app
COPY target/*.jar app.jar

# Set the entry point for the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
