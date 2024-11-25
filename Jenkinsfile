#!groovy

@Library('pipeline@test') _

def print = printBuildStep
def appName = "tetete"
def resultStatus = "SUCCESS"

properties([disableConcurrentBuilds()])

node('builder') { // node/agent

  tools {
    jdk 'GraalVM'
//     jdk 'jdk_1.6.0_45'
  }

  stage('Build') {
    print.startPipeline(appName)
    cleanWs()
    checkout scm
    print.gradleBuildApp(appName)
    print.gradleBuildProject()
//     sh './gradlew clean build --refresh-dependencies'
//     sh './gradlew clean build -x test -Dquarkus.native.enabled=true -Dquarkus.native.builder-image=graalvm --refresh-dependencies'
    print.gradleBuildProjectResult(resultStatus)
  }

//   stage('Run') {
//     print.runApp(appName)
//     print.dockerRemoveContainer()
//     sh 'docker rm -f appmarket'
//     print.dockerRemoveContainerResult(resultStatus)
//     print.dockerRemoveImager()
//     sh 'docker rmi -f appmarket:tag'
//     print.dockerRemoveImagerResult(resultStatus)
//     print.dockerBuildImager()
//     sh 'docker build -t appmarket:tag .'
//     print.dockerBuildImagerResult(resultStatus)
//     print.dockerRunContainer()
//     sh 'docker run --restart=always --name appmarket --env-file /externaldata/appmarket/env/appmarket.env -p 1410:1410 -v /appmarket/logs:/appmarket/logs -v /appmarket/apk:/appmarket/apk -u root -e TZ=Europe/Moscow -d appmarket:tag'
//     print.dockerRunContainerResult(resultStatus)
//     print.endPipeline(appName)
//   }
}