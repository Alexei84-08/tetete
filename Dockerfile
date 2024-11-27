## Stage 1 : build with maven builder image with native capabilities
##FROM quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-21 AS build
FROM quay.io/quarkus/ubi-quarkus-graalvmce-builder-image:jdk-21 AS builder
#LABEL stage=quarkus-builder
ARG BUILD_ID
LABEL stage=builder
LABEL build=$BUILD_ID
USER root
RUN microdnf install findutils
COPY --chown=quarkus:quarkus gradlew /code/gradlew
COPY --chown=quarkus:quarkus gradle /code/gradle
COPY --chown=quarkus:quarkus build.gradle /code/
COPY --chown=quarkus:quarkus settings.gradle /code/
COPY --chown=quarkus:quarkus gradle.properties /code/
USER quarkus
WORKDIR /code
COPY src /code/src
RUN ./gradlew --stacktrace build -Dquarkus.native.enabled=true

## Stage 2 : create the docker final image
FROM quay.io/quarkus/quarkus-micro-image:2.0
WORKDIR /work/
COPY --from=builder /code/build/*-runner /work/application
RUN chmod 775 /work
EXPOSE 8183
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
