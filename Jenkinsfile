pipeline {
    agent any

    environment {
        REGISTRY = 'vignesh221193'
    }

    stages {
        stage('Set Image Details') {
            steps {
                script {
                    def branch = env.GIT_BRANCH?.replaceFirst(/^origin\//, '')
                    if (branch == 'main') {
                        env.IMAGE_NAME = "${REGISTRY}/guvi_project_01_prod"
                        env.IMAGE_TAG = 'prod'
                    } else {
                        env.IMAGE_NAME = "${REGISTRY}/guvi_project_01_dev"
                        env.IMAGE_TAG = 'dev'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Image: ${env.IMAGE_NAME}:${env.IMAGE_TAG}"
                sh "docker build -t ${env.IMAGE_NAME}:${env.IMAGE_TAG} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push ${env.IMAGE_NAME}:${env.IMAGE_TAG}"
                }
            }
        }
    }
}
