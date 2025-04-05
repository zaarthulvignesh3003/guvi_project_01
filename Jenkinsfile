pipeline {
    agent any
    environment {
        IMAGE_NAME = "guvi_project_01"
        DOCKERHUB_USER = "vignesh221193"
    }

    stages {
        stage('Set Image Details') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        TAG = "prod"
                    } else if (env.BRANCH_NAME == 'dev') {
                        TAG = "dev"
                    }
                    FULL_IMAGE_NAME = "${DOCKERHUB_USER}/${IMAGE_NAME}_${TAG}:${TAG}"
                    echo "Image: ${FULL_IMAGE_NAME}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $FULL_IMAGE_NAME .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin
                        docker push $FULL_IMAGE_NAME
                    '''
                }
            }
        }
    }
}
