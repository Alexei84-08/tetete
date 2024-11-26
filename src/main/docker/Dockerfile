## Stage 1 : build with maven builder image with native capabilities
##FROM quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-21 AS build
FROM quay.io/quarkus/ubi-quarkus-graalvmce-builder-image:jdk-21 AS build
USER root
#RUN microdnf install findutils
RUN apk update
RUN /usr/sbin/apk update && /usr/sbin/apk add findutils
#RUN apt-get update && apt-get add findutils
COPY --chown=quarkus:quarkus gradlew /code/gradlew
COPY --chown=quarkus:quarkus gradle /code/gradle
COPY --chown=quarkus:quarkus build.gradle /code/
COPY --chown=quarkus:quarkus settings.gradle /code/
COPY --chown=quarkus:quarkus gradle.properties /code/
USER quarkus
WORKDIR /code
COPY src /code/src
##RUN ./gradlew addExtension --extensions=quarkus-container-image-docker build -Dquarkus.native.enabled=true -Dquarkus.native \
##    .container-build=true -Dquarkus.native.native-image-xmx=6g
#RUN ./gradlew addExtension --stacktrace  --extensions=quarkus-container-image-docker build -Dquarkus.platform.version=3.11.0 \
#    -Dquarkus.native.enabled=true
#RUN ./gradlew addExtension --stacktrace  --extensions=quarkus-container-image-docker build -Dquarkus.native.enabled=true
RUN ./gradlew --stacktrace build -Dquarkus.native.enabled=true

## Stage 2 : create the docker final image
FROM quay.io/quarkus/quarkus-micro-image:2.0
WORKDIR /work/
COPY --from=build /code/build/*-runner /work/application
RUN chmod 775 /work
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]