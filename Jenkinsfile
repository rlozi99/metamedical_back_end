pipeline {
    agent any

    environment {
        AZURE_SUBSCRIPTION_ID = 'c8ce3edc-0522-48a3-b7e4-afe8e3d731d9'
        AZURE_TENANT_ID = '4ccd6048-181f-43a0-ba5a-7f48e8a4fa35'
        RESOURCE_GROUP = 'AKS'
        NAMESPACE = 'back'


        CONTAINER_REGISTRY = 'goodbirdacr.azurecr.io'
        REPO = 'medical/back'
        IMAGE_NAME = 'medical/back:latest'

        GIT_CREDENTIALS_ID = 'jenkins-git-access'
        GIT_REPOSITORY = "rlozi99/metamedical_back_ops" 

        NEW_IMAGE_TAG = "${env.BRANCH_NAME}-${env.BUILD_ID}"

        KUBECONFIG = '/home/azureuser/.kube/config'

        JAR_FILE_PATH = 'build/libs/demo-0.0.1-SNAPSHOT.jar'
    }
    stages{
        stage('Check BRANCH_NAME') {
            steps {
                script {
                    echo "Current BRANCH_NAME is ${env.BRANCH_NAME}"
                }
            }
        }
        stage('Initialize..') {
            steps {
                script {
                    def branch = env.BRANCH_NAME
                    echo "Checked out branch: ${branch}"
                    
                    if (branch == 'dev') {
                        env.TAG = 'dev'
                        env.DIR_NAME = "development"
                    } else if (branch == 'stg') {
                        env.TAG = 'stg'
                        env.DIR_NAME = "staging"
                    } else if (branch == 'prod') {
                        env.TAG = 'latest'
                        env.DIR_NAME = "production"
                    } else {
                        env.TAG = 'unknown'
                        env.DIR_NAME = "unknown"
                    }
                    echo "TAG is now set to ${env.TAG}"
                }
            }
        }  
        // stage('SonarQube Analysis') {
        //     steps {
        //         script {
        //             def scannerHome = tool 'sonarqube_scanner'
        //             withSonarQubeEnv('SonarQubeServer') {
        //                 // SonarScanner 실행 명령에 -X 옵션 추가
        //                 sh "${scannerHome}/bin/sonar-scanner -X"
        //             }
        //         }
        //     }
        // }
        stage('Grant Execute Permission to Gradle Wrapper') {
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
        // stage('SonarQube Analysis') {
        //             steps {
        //                 withSonarQubeEnv('SonarQubeServer') {
        //                     script {
        //                         // SonarQube 스캔 명령어 실행
        //                         sh "./gradlew sonar clean build --warning-mode=none -x test --info"
        //                     }
        //                 }
        //             }
        //         }

        // stage('Trivy Security') {
        //       steps {
        //           sh 'chmod +x trivy-image-scan.sh' // 스크립트에 실행 권한 추가
        //           sh './trivy-image-scan.sh' // Trivy 이미지 스캔 실행
        //       }
        // }

        stage('Build and Push Docker Image to ACR') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'acr-credential-id', passwordVariable: 'ACR_PASSWORD', usernameVariable: 'ACR_USERNAME')]) {
                        sh "az acr login --name $CONTAINER_REGISTRY --username $ACR_USERNAME --password $ACR_PASSWORD"
                        sh "echo $NEW_IMAGE_TAG"
                        sh "docker build -t $CONTAINER_REGISTRY/$REPO:$NEW_IMAGE_TAG ."
                        sh "docker push $CONTAINER_REGISTRY/$REPO:$NEW_IMAGE_TAG"
                    }
                }
            }
        }
        stage('Checkout GitOps') {
                    steps {
                        git branch: BRANCH_NAME,
                            credentialsId: 'jenkins-git-access',
                            url: "https://github.com/${GIT_REPOSITORY}"
                    }
                }
        stage('Update Kubernetes Configuration..') {
            steps {
                script {
                    sh "ls -la"

                    withKubeConfig([credentialsId: 'kubeconfig-credentials-id']) {
                        sh "ls -la"

                        dir("overlays/${env.DIR_NAME}") {
                            sh "ls -la"
                            sh "kustomize build . | kubectl apply -f - -n ${NAMESPACE}"
                            sh "kustomize edit set image ${CONTAINER_REGISTRY}/${REPO}=${CONTAINER_REGISTRY}/${REPO}:${NEW_IMAGE_TAG}"
                            sh "git add ."
                            sh "git commit -m 'Update image to ${NEW_IMAGE_TAG}'"
                        }
                    }
                }
            }
        }
        stage('Commit and Push Changes to GitOps Repository..') {
            steps {
                script {
                    dir("overlays/${env.DIR_NAME}") {
                        // GitOps 저장소로 변경 사항을 커밋하고 푸시합니다.
                        sh "git config user.email 'rlozi1999@gmail.com'"
                        sh "git config user.name 'rlozi99'"
                        // Credential을 사용하여 GitHub에 push
                        withCredentials([usernamePassword(credentialsId: 'jenkins-git-access', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                            // GIT_USERNAME과 GIT_PASSWORD 환경변수를 사용하여 push
                            dir("overlays/${env.DIR_NAME}") {
                                sh("git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_REPOSITORY}.git ${env.BRANCH_NAME}")
                            }
                        }
                    }
                }
            }
        }
    }
}
def withKubeConfig(Map args, Closure body) {
    withCredentials([file(credentialsId: args.credentialsId, variable: 'KUBECONFIG')]) {
        body.call()
    }
}