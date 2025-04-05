def branch = env.BRANCH_NAME

pipeline {
    agent any

    environment {
        IMAGE_NAME = branch == 'main' ? 'vignesh221193/guvi_project_01_prod' : 'vignesh221193/guvi_project_01_dev'
        IMAGE_TAG = branch == 'main' ? 'prod' : 'dev'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push $IMAGE_NAME:$IMAGE_TAG
                    """
                }
            }
        }
    }
}
