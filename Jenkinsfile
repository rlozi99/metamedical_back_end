pipeline {
    agent any

    environment {
        AZURE_SUBSCRIPTION_ID='c8ce3edc-0522-48a3-b7e4-afe8e3d731d9'
        AZURE_TENANT_ID='3d0bec40-7719-479d-828a-f7adf7deea16'
        CONTAINER_REGISTRY='metanetcr.azurecr.io'
        RESOURCE_GROUP='metanet'
        REPO="kwujio/myhttpd"
        IMAGE_NAME="kwujio/myhttpd:latest"
        TAG="latest"
			
    }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

    stage('Build and Push Docker Image to ACR') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'acr-credential-id', passwordVariable: 'ACR_PASSWORD', usernameVariable: 'ACR_USERNAME')]) {
                        // Log in to ACR
                        sh "az acr login --name $CONTAINER_REGISTRY --username $ACR_USERNAME --password $ACR_PASSWORD"

                        // Build and push Docker image to ACR
                        sh "docker build -t $REPO:$TAG ."
                        sh "docker tag $REPO:$TAG $CONTAINER_REGISTRY/$IMAGE_NAME"
                        sh "docker push $CONTAINER_REGISTRY/$IMAGE_NAME"

                        // Log out from ACR (optional)
                        sh "az acr logout --name $CONTAINER_REGISTRY"
                    }
                }
            }
        }
    }
}