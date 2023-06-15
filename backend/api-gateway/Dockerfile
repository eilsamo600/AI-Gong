FROM openjdk:17-jdk-slim
RUN mvnw clean package
ARG JAR_FILE_PATH=target/*.jar
COPY ${JAR_FILE_PATH} app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]