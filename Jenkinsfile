pipeline {
    agent { label 'x86' }


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

                    withDockerRegistry([ credentialsId: "docker_hub", url: "" ]) {
                      sh  "docker image tag corrade:latest sysconfig/corrade-11-docker:${OS_Version}"
                      sh  "docker push sysconfig/corrade-11-docker:${OS_Version}"
                      sh  "docker rmi sysconfig/corrade-11-docker:${OS_Version}"
                    }

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
