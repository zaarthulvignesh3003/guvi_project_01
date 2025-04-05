pipeline {
    agent any

    environment {
        IMAGE_NAME = "guvi_project"
        DOCKER_HUB_USER = "vignesh221193"
        DOCKER_HUB_CRED = credentials('dockerhub-cred') // ID you create in Jenkins
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def tag = env.BRANCH_NAME == 'main' ? 'prod' : 'dev'
                    sh "docker build -t $DOCKER_HUB_USER/${IMAGE_NAME}:${tag} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def tag = env.BRANCH_NAME == 'main' ? 'prod' : 'dev'
                    sh """
                        echo $DOCKER_HUB_CRED_PSW | docker login -u $DOCKER_HUB_CRED_USR --password-stdin
                        docker push $DOCKER_HUB_USER/${IMAGE_NAME}:${tag}
                    """
                }
            }
        }
    }
}
