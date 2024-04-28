# Use official Maven image as the base image
FROM maven:3.8.1-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the source code and pom.xml to the container
COPY /app/pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Use AdoptOpenJDK image as the base image
FROM adoptopenjdk/openjdk11:alpine-jre

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage to the container
COPY --from=build /app/target/your-app.jar ./app.jar

# Expose the port the application runs on
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "app.jar"]
