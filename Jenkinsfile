pipeline{
    agent {
        label 'jenkins-slave'
    }
    tools{
        maven 'MAVEN3.8.7'
    }
    stages{
        stage('git-hub-webhook')
        {
            steps{
                script{
                    properties([pipelineTriggers([githubPush()])])
                }
            }
        }
        stage('git-clone'){
            steps{
            git branch: 'FIRST', url: 'https://github.com/chaithanya1812/test-5--springboot-mongo-App-docker-compose.git'
            }
        }
        stage('Maven-Build'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Build-image'){
            steps {
               sh 'docker build -t chaitu1812/springbootmongo .'
            }
        }
    
        stage('Docker-login'){
            steps{
                withCredentials([string(credentialsId: 'ddockerloginn', variable: 'login')]) {
                     sh 'docker login -u chaitu1812 --password $login || true'
                }
                sh 'docker push chaitu1812/springbootmongo'
                sh 'docker rmi chaitu1812/springbootmongo'
            }
        }
/*
1)MAKE sure that every server docker status running and install docker-compose also
2)add ec2-user into docker group by executing following command like
$ usermod -aG docker ec2-user
*/
        stage('SSH-dev-server'){
            steps{
               sshagent(['LOGININTO']) {
                   sh "scp  -o StrictHostKeyChecking=no docker-compose.yaml docker-compose-dev.yaml ec2-user@13.232.115.66:/home/ec2-user/"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@13.232.115.66 docker-compose -f docker-compose.yaml -f docker-compose-dev.yaml up -d"
                 }
               
            }
        }
        stage('SSH-qa-server'){
            steps{
               sshagent(['LOGININTO']) {
                   sh "scp  -o StrictHostKeyChecking=no docker-compose.yaml docker-compose-qa.yaml ec2-user@35.154.194.230:/home/ec2-user/"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@35.154.194.230  docker-compose -f docker-compose.yaml -f docker-compose-qa.yaml up -d"
                 }
            }
        }
        stage('SSH-prod-server'){
            steps{
               sshagent(['LOGININTO']) {
                   sh "scp  -o StrictHostKeyChecking=no docker-compose.yaml docker-compose-prod.yaml ec2-user@15.206.168.157:/home/ec2-user/"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@15.206.168.157 docker-compose -f docker-compose.yaml -f docker-compose-prod.yaml up -d"
                }
            }
        }
        
   }
}
