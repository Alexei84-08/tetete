#FROM openjdk:17-jdk-alpine
#WORKDIR /appmarket
#ARG JAR_FILE=./build/libs/appmarket-0.0.1-SNAPSHOT.jar
#ARG JCERT=./build/resources/main/ks/server.pem
#COPY ${JCERT} /appmarket/server.pem
#RUN keytool -importcert -keypass changeit -alias keycloak -file /appmarket/server.pem -keystore $JAVA_HOME/lib/security/cacerts -noprompt -storepass changeit
#COPY ${JAR_FILE} /appmarket/appmarket.jar
#ENTRYPOINT exec java $JAVA_OPTS -jar /appmarket/appmarket.jar


FROM registry.access.redhat.com/ubi8/ubi-minimal:8.10
WORKDIR /work/
RUN chown 1001 /work \
    && chmod "g+rwX" /work \
    && chown 1001:root /work
COPY --chown=1001:root target/*-runner /work/application

EXPOSE 8080
USER 1001

CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
