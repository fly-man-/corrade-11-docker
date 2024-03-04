pipeline {
    agent { label 'x86' }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker_hub_2024')
    }

    stages {

        stage('Setup Parameters') {
            steps {
                script {
                    properties([
                        parameters([
                            choice(
                                choices: ['debian-slim', 'centos'],
                                name: 'OS_Version'
                            )
                        ])
                    ])
                }
            }
        }


        stage('Get CentOS image') {
            when {
                expression { params.OS_Version == "centos" }
            }
            steps {
                sh "docker pull centos:latest"
            }
        }
        stage('Get Debian slim image') {
            when {
                expression { params.OS_Version == "debian-slim" }
            }
            steps {
                sh "docker pull debian:stable-slim"
            }
        }
        
        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_USR / $DOCKERHUB_CREDENTIALS_PSW'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }

            post 
        }


        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/sysconfig/corrade-11-docker.git'

               
                sh "docker build --no-cache -t corrade -f Dockerfile-${OS_Version} ."

            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {

                    sh  "docker image tag corrade:latest sysconfig/corrade-11-docker:${OS_Version}"
                    sh  "docker push sysconfig/corrade-11-docker:${OS_Version}"
                    sh  "docker rmi sysconfig/corrade-11-docker:${OS_Version}"

                }
            }
        }
        stage('Cleanup Centos') {
            when {
                expression { params.OS_Version.equals("centos") }
            }
            steps {
                sh "docker rmi centos:latest"
            } 
        }
        stage('Cleanup Debian') {
            when {
                expression { params.OS_Version.equals("debian-slim") }
            }
            steps {
                    sh "docker rmi debian:stable-slim"
            } 
        }

    }
    
}
