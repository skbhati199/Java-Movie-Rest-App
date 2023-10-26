# Use an official Maven runtime as a parent image
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the source code and the pom.xml to the container
COPY ./ /app

# Build the Maven project
RUN mvn clean package

# Use the official OpenJDK 17 JRE image as the base image for the final image
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory for the application
WORKDIR /app

# Copy the JAR file generated in the previous build stage
COPY --from=build /app/target/movies-app.jar /app/app.jar

# Expose the port your application listens on (adjust the port as needed)
EXPOSE 8080

# Define the command to run your Java application
CMD ["java", "-jar", "app.jar"]
