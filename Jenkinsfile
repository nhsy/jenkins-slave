pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    triggers {
        cron('@weekly')
    }
    environment {
        IMAGE = 'jenkins-slave'
        REGISTRY = 'dizzyplan'
        TAG = "latest"
    }

    stages {
        stage("Pull") {
            steps {
                sh "docker pull jenkins/inbound-agent"
            }
        }
        stage("Build") {
            steps {
                sh "docker build --rm --no-cache --tag $REGISTRY/$IMAGE:$TAG ."
            }
        }
        stage("Push") {
            when {
                branch 'master'
            }
            steps {
                withDockerRegistry([ credentialsId: 'dockerhub', url: '' ]) {
                    sh "docker push $REGISTRY/$IMAGE:$TAG"

                }
            }
        }
    }

    post {
        success {
            sh "docker image prune --filter=\"label=name=\$IMAGE\" -f"
            sh "docker image prune --filter=\"label=name=\$REGISTRY/\$IMAGE\" -f"
        }
        always {
            deleteDir()
        }
    }
}
