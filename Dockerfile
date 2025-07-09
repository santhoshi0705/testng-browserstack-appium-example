# Stage 1: Build with Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Compile and package the application
RUN mvn clean package -DskipTests

# Stage 2: Run the application with just the JDK
FROM eclipse-temurin:17-jdk

# Set work directory
WORKDIR /app

# Copy built JAR from previous stage
COPY --from=build /app/target/*.jar app.jar

# Set the main class if needed (optional)
# ENV JAVA_OPTS=""

# Default command to run the app
CMD ["java", "-jar", "app.jar"]
