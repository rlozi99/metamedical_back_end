pipeline {
    agent any

    environment {
        AZURE_SUBSCRIPTION_ID = 'c8ce3edc-0522-48a3-b7e4-afe8e3d731d9'
        AZURE_TENANT_ID = 'bac4b78b-fcc2-4614-a32b-b69330b1af9f'
        CONTAINER_REGISTRY = 'goodacr.azurecr.io'
        RESOURCE_GROUP = 'AKS'
        REPO = 'kwujio/back'
        IMAGE_NAME = 'kwujio/back:latest'
        TAG = 'latest'
        JAR_FILE_PATH = 'build/libs/demo-0.0.1-SNAPSHOT.jar'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Grant Execute Permission to Gradle Wrapper') {
                    steps {
                        sh 'chmod +x ./gradlew'
                    }
                }

 // JAR 파일 빌드 단계 추가
        stage('Build JAR') {
            steps {
                script {
                    // Gradle 또는 Maven을 사용하여 JAR 파일 빌드
                    sh './gradlew build' // 또는 'mvn package'
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
