pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIAL = credentials('ex') // Jenkins Credential ID for Docker Hub
        DOCKER_REGISTRY = 'docker.io'
        IMAGE_NAME = 'kwujio'
        DOCKER_REGISTRY_USERNAME = 'kwujio'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build JAR') {
            steps {
                script {
                    // Run Gradle build to create JAR file
                    sh "./gradlew build"
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'ex', variable: 'DOCKER_HUB_CREDENTIAL')]) {
                        // Log in to Docker Hub
                        sh "echo $DOCKER_HUB_CREDENTIAL | docker login -u $DOCKER_REGISTRY_USERNAME --password-stdin $DOCKER_REGISTRY"

                        // Build and push Docker image
                        sh "docker build -t $DOCKER_REGISTRY/$IMAGE_NAME ."
                        sh "docker push $DOCKER_REGISTRY/$IMAGE_NAME"

                        // Log out from Docker Hub (optional)
                        sh "docker logout $DOCKER_REGISTRY"
                    }
                }
            }
        }
    }
}