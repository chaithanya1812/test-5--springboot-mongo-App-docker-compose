FROM maven:3.8-openjdk-18-slim as build
WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:8-alpine
RUN apk update && apk add /bin/sh
RUN mkdir -p /opt/app
COPY --from=build  /app/target/spring-boot-mongo-1.0.jar /opt/app/spring-boot-mongo.jar
WORKDIR /opt/app
EXPOSE 8080
CMD ["java" ,"-jar","./spring-boot-mongo.jar"]
