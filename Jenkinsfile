def imgremv = "docker rmi -f chaitu1812/javawebapp"

pipeline{
    agent {
        label 'docker-compse'
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
            git branch: 'FIRST', url: 'https://github.com/chaithanya1812/test-6--springboot-mongo-App-docker-compose.git'
            }
        }
        stage('Build-image'){
            steps{
                // building image of javawebapp(service)
               sh 'docker-compose build javawebapp'
               // it will build the image in the name of chaitu1812/javawebapp
            }
        }
    
        stage('Docker-login'){
            steps{
                withCredentials([string(credentialsId: 'ddockerloginn', variable: 'login')]) {
                     sh 'docker login -u chaitu1812 --password $login || true'
                }
                sh 'docker push chaitu1812/javawebapp'
                sh 'docker rmi chaitu1812/javawebapp'
            }
        }
/*
1)MAKE sure that every server docker status running and,
2)add ec2-user into docker group by executing following command like
$ usermod -aG docker ec2-user
3) install docker-compose jenkins-slave and also install three environments.
*/
        stage('SSH-dev-server'){
            steps{
             script {    
               sshagent(['LOGININTO']) {
                  // sh "ssh -o StrictHostKeyChecking=no ec2-user@3.110.87.126 ${conremv}" 
                  sh "ssh -o StrictHostKeyChecking=no ec2-user@3.110.87.126  docker-compose -f docker-compose.yaml -f docker-compose-dev.yaml down"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@3.110.87.126 ${imgremv}"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@3.110.87.126 docker pull chaitu1812/javawebapp"
                   sh "scp  -o StrictHostKeyChecking=no docker-compose.yaml docker-compose-dev.yaml ec2-user@3.110.87.126:/home/ec2-user/"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@3.110.87.126  docker-compose -f docker-compose.yaml -f docker-compose-dev.yaml up -d"
                 }
             } 
               
            }
        }
        stage('SSH-qa-server'){
            steps{
             script {    
               sshagent(['LOGININTO']) {
                  // sh "ssh -o StrictHostKeyChecking=no ec2-user@65.1.64.170 ${conremv}"  
                  sh "ssh -o StrictHostKeyChecking=no ec2-user@65.1.64.170  docker-compose -f docker-compose.yaml -f docker-compose-qa.yaml down"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@65.1.64.170 ${imgremv}"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@65.1.64.170 docker pull chaitu1812/javawebapp"
                   sh "scp  -o StrictHostKeyChecking=no docker-compose.yaml docker-compose-qa.yaml ec2-user@65.1.64.170:/home/ec2-user/"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@65.1.64.170  docker-compose -f docker-compose.yaml -f docker-compose-qa.yaml up -d"
                 }
             } 
               
            }
        }
        stage('SSH-prod-server'){
            steps{
             script {    
               sshagent(['LOGININTO']) {
                   //sh "ssh -o StrictHostKeyChecking=no ec2-user@3.111.245.206 ${conremv}" 
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@3.111.245.206  docker-compose -f docker-compose.yaml -f docker-compose-prod.yaml down"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@3.111.245.206 ${imgremv}"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@3.111.245.206 docker pull chaitu1812/javawebapp"
                   sh "scp  -o StrictHostKeyChecking=no docker-compose.yaml docker-compose-prod.yaml ec2-user@3.111.245.206:/home/ec2-user/"
                   sh "ssh -o StrictHostKeyChecking=no ec2-user@3.111.245.206  docker-compose -f docker-compose.yaml -f docker-compose-prod.yaml up -d"
                 }
             } 
               
            }
        }
        
        
        
   }
}
