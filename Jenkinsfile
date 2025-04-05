pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'vignesh221193'
        IMAGE_NAME = 'guvi_project_01'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/zaarthulvignesh3003/guvi_project_01.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_HUB_USER/$IMAGE_NAME:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-password', variable: 'DOCKER_HUB_PASS')]) {
                    sh """
                        echo $DOCKER_HUB_PASS | docker login -u $DOCKER_HUB_USER --password-stdin
                        docker push $DOCKER_HUB_USER/$IMAGE_NAME:latest
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                // SSH into EC2 and run docker pull + docker run
                sh '''
                    ssh -o StrictHostKeyChecking=no ec2-user@18.234.147.86 '
                        docker pull $DOCKER_HUB_USER/$IMAGE_NAME:latest &&
                        docker stop app || true &&
                        docker rm app || true &&
                        docker run -d --name app -p 80:80 $DOCKER_HUB_USER/$IMAGE_NAME:latest
                    '
                '''
            }
        }
    }
}
