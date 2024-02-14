pipeline {
    agent any

    environment {
        AZURE_SUBSCRIPTION_ID = 'c8ce3edc-0522-48a3-b7e4-afe8e3d731d9'
        AZURE_TENANT_ID = '4ccd6048-181f-43a0-ba5a-7f48e8a4fa35'
        CONTAINER_REGISTRY = 'goodbirdacr.azurecr.io'
        RESOURCE_GROUP = 'AKS'
        REPO = 'medicine/back'
        IMAGE_NAME = 'medicine/back:latest'
        TAG = 'latest'
        JAR_FILE_PATH = 'build/libs/demo-0.0.1-SNAPSHOT.jar'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Grant Execute Permission to Gradle Wrapper..') {
                    steps {
                        sh 'chmod +x ./gradlew'
                    }
                }

 // JAR 파일 빌드 단계 추가
        stage('Build JAR') {
            steps {
                script {
                    withEnv(['JAVA_HOME=/usr/lib/jvm/jdk-21.0.2']) {
                        // Gradle을 사용하여 JAR 파일 빌드
                        sh './gradlew --version'
                        sh './gradlew clean build --warning-mode=none -x test --info'
                    }
                }
            }
        }
        stage('Build and Push Docker Image to ACR') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'acr-credential-id', passwordVariable: 'ACR_PASSWORD', usernameVariable: 'ACR_USERNAME')]) {
                        // Log in to ACR
                        sh "az acr login --name $CONTAINER_REGISTRY --username $ACR_USERNAME --password $ACR_PASSWORD"
                        // Dockerfile에 있는 JAR 파일을 사용하여 Docker 이미지 빌드
                        sh "docker build -t $REPO:$TAG ."
                        // 이미지 태그 지정 및 ACR로 푸시
                        sh "docker tag $REPO:$TAG $CONTAINER_REGISTRY/$IMAGE_NAME"
                        sh "docker push $CONTAINER_REGISTRY/$IMAGE_NAME"
                    }
                }
            }
        }
    }
}