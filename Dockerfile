# ## Build stage
# FROM maven:3.8.4-jdk-11-slim AS build
# WORKDIR /app
# COPY pom.xml .
# RUN mvn dependency:go-offline

# COPY src/ /app/src/
# RUN mvn clean package -DskipTests

# # Step : Package image
# FROM openjdk:11-jdk-slim
# COPY --from=build /app/target/*.jar app.jar
# EXPOSE 8080 8000
# ENTRYPOINT ["java", "-jar" , "app.jar"]

FROM maven:3.9.2-eclipse-temurin-17-alpine as build

# COPY ./src src/
# COPY ./pom.xml pom.xml
COPY . .

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
COPY --from=build ../target/spring-boot-webrtc-peer2peer-0.0.1-SNAPSHOT.jar spring-boot-webrtc-peer2peer.jar
EXPOSE 8080 8000
CMD ["java","-jar","./spring-boot-webrtc-peer2peer.jar"]