pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "instantprachi/website-nginx:latest"
        DOCKER_HUB_CREDENTIALS = 'dockerhub-credentials'  // Jenkins credential ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/YogeshDharya/Website-Responsive-CICD-nginx.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "$DOCKER_HUB_CREDENTIALS", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $DOCKER_IMAGE
                        docker logout
                        """
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
            ansiblePlaybook(
            playbook: 'ansible/deploy.yml',
            inventory: 'ansible/hosts',
            extras: '--extra-vars "image=instantprachi/website-nginx:latest"'
            )
        }
    }

    }

    post {
        success {
            echo "✅ Docker image successfully built and pushed to Docker Hub!"
        }
        failure {
            echo "❌ Build or push failed — check Jenkins logs."
        }
    }
}
