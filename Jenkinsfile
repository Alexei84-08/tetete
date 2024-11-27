#!groovy

@Library('pipeline@test') _

def print = printBuildStep
def appName = "izo"
def resultStatus = "SUCCESS"
def rootPath = develop_root_path

properties([disableConcurrentBuilds()])

node('builder') { // node/agent

stage('Build') {
echo '========================================================================'
echo rootPath + '/' + appName
echo '------------------------------'

    sh 'docker rm -f izo'

    sh 'docker rmi -f izo:tag'

    sh 'docker build -t izo:tag .'

    sh 'docker run --restart=always --name izo -p 8183:8183 -v $rootPath/izo/logs:/izo/logs -u root -e TZ=Europe/Moscow -d izo:tag'


// sh 'echo $develop_root_path'
}


//   stage('Build') {
//     print.startPipeline(appName)
//     cleanWs()
//     checkout scm
//     print.gradleBuildApp(appName)
//     print.gradleBuildProject()
//     //     sh './gradlew clean build --refresh-dependencies'
//     //     sh './gradlew clean build -x test -Dquarkus.native.enabled=true -Dquarkus.native.builder-image=graalvm --refresh-dependencies'
//     //     sh 'GRAALVM_HOME=/src/jvm/graalvm-jdk-21.0.5+9.1 ./gradlew clean build -x test -Dquarkus.native.enabled=true -Dquarkus.native.builder-image=graalvm
//     //     sh 'GRAALVM_HOME=/src/jvm/graalvm-jdk-21.0.5+9.1'
//     //     sh 'JAVA_HOME=/src/jvm/graalvm-jdk-21.0.5+9.1'
//     //     sh './gradlew build -Dquarkus.native.enabled=true -Dquarkus.native.container-build=true'
//     //     sh 'docker buildx -f src/main/docker/Dockerfile -t quarkus-quickstart/getting-started .'
//     print.dockerRemoveContainer()
//     sh 'docker rm -f izo'
//     print.dockerRemoveContainerResult(resultStatus)
//     print.dockerRemoveImager()
//     sh 'docker rmi -f izo:tag'
//     print.dockerRemoveImagerResult(resultStatus)
//     print.dockerBuildImager()
//     sh 'docker build -t izo:tag .'
//     print.dockerBuildImagerResult(resultStatus)
//     //     sh './gradlew build -Dquarkus.native.enabled=true -Dquarkus.native.container-build=true'
//     //     sh './gradlew -Dquarkus.native.container-build=true -Dquarkus.package.type=native build -Dquarkus.native.remote-container-build=true'
//     //     sh './gradlew -Dquarkus.native.container-build=true -Dquarkus.package.type=native build'
//     //     sh './gradlew clean build -x test --stacktrace -Dquarkus.native.enabled=true -Dquarkus.native.builder-image=graalvm'
//     //     sh './gradlew clean quarkusBuild -x test --stacktrace -Dquarkus.native.enabled=true -Dquarkus.native.builder-image=graalvm'
//
//     print.gradleBuildProjectResult(resultStatus)
//   }

//   stage('Run') {
// //     print.runApp(appName)
// //     print.dockerRemoveContainer()
// //     sh 'docker rm -f appmarket'
// //     print.dockerRemoveContainerResult(resultStatus)
// //     print.dockerRemoveImager()
// //     sh 'docker rmi -f appmarket:tag'
// //     print.dockerRemoveImagerResult(resultStatus)
// //     print.dockerBuildImager()
// //     sh 'docker build -t appmarket:tag .'
// //     print.dockerBuildImagerResult(resultStatus)
//     print.dockerRunContainer()
//     sh 'docker run --restart=always --name izo -p 8183:8183 -v /izo/logs:/izo/logs -u root -e TZ=Europe/Moscow -d izo:tag'
//     print.dockerRunContainerResult(resultStatus)
//     print.endPipeline(appName)
//   }
}