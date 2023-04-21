pipeline {
  agent any

  tools {
      maven 'M2_HOME'
     
        }
	environment {
       AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
       AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
	
  stages {
     stage('checkout'){
       steps {
          echo 'checkout the code from GitRepo'
          git 'https://github.com/prafullashilimkar/star-agile-health-care.git'
                    }
            }
   

     stage('Build the  Application'){
               steps {
                   echo "Cleaning.... Compiling......Testing.........Packaging"
                   sh 'mvn clean package'
                    }
		   } 
      stage('publish Reports'){
              steps {
                 publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/health-careapp/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])           
                    }
          }

     stage('Docker Image Creation'){
               steps {
                      sh 'docker build -t prafullla/healthcare-app:latest  .'
                     }
                   }

     stage('Push Image to DockerHub'){
               steps {
                   withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                   sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh 'docker push prafullla/healthcare-app:latest'
		   }
                }
            }
	  
	  stage ('Configure Test-server with Terraform, Ansible and then Deploying'){
           steps {
		 dir('my-serverfiles'){
                 sh 'sudo chmod 600 jenkinskey1.pem'
                 sh 'terraform init'
                 sh 'terraform validate'
                 sh 'terraform apply --auto-approve'
                }
            }
        }
	  
     
       
       // steps{
      //sh 'terrafrom apply -auto-approve'
     //sleep 10
       //    }
       // }
     //stage('deploy to kubernates') {
     //steps{
     //sshagent(['K8s']){
     //sh 'scp -o StrictHostKeyChecking=no Deployment.yml

     //ubuntu@ip-172-31-33-165:/home/ubuntu'

     //script{
     //try{
     //sh 'ssh ubuntu@ip-172-31-33-165 kubectl apply -f .'
     //}catch(error)
    // {
     //sh 'ssh ubuntu@ip-172-31-33-165 kubectl create -f .'
     //}
     //}
     //}
     //}
     }
    }

