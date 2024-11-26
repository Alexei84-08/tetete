## Stage 1 : build with maven builder image with native capabilities
FROM quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-21 AS build
USER root
#RUN microdnf install findutils
RUN apk update && apk add findutils
COPY --chown=quarkus:quarkus gradlew /code/gradlew
COPY --chown=quarkus:quarkus gradle /code/gradle
COPY --chown=quarkus:quarkus build.gradle /code/
COPY --chown=quarkus:quarkus settings.gradle /code/
COPY --chown=quarkus:quarkus gradle.properties /code/
USER quarkus
WORKDIR /code
COPY src /code/src
RUN ./gradlew build -Dquarkus.native.enabled=true

## Stage 2 : create the docker final image
FROM quay.io/quarkus/quarkus-micro-image:2.0
WORKDIR /work/
COPY --from=build /code/build/*-runner /work/application
RUN chmod 775 /work
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]


#FROM openjdk:17-jdk-alpine
#WORKDIR /appmarket
#ARG JAR_FILE=./build/libs/appmarket-0.0.1-SNAPSHOT.jar
#ARG JCERT=./build/resources/main/ks/server.pem
#COPY ${JCERT} /appmarket/server.pem
#RUN keytool -importcert -keypass changeit -alias keycloak -file /appmarket/server.pem -keystore $JAVA_HOME/lib/security/cacerts -noprompt -storepass changeit
#COPY ${JAR_FILE} /appmarket/appmarket.jar
#ENTRYPOINT exec java $JAVA_OPTS -jar /appmarket/appmarket.jar


#FROM registry.access.redhat.com/ubi8/ubi-minimal:8.10
#WORKDIR /work/
#RUN chown 1001 /work \
#    && chmod "g+rwX" /work \
#    && chown 1001:root /work
#COPY --chown=1001:root target/*-runner /work/application
#
#EXPOSE 8080
#USER 1001
#
#CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
