pipeline {
  agent any

  tools {
    maven 'M2_HOME'
    
    }
  /*environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }*/
  stages {
    stage('CheckOut') {
      steps {
        echo 'Checkout the source code from GitHub'
        git 'https://github.com/prafullashilimkar/star-agilehealth-care-.git' 
            }
    }
    
    stage('Package the Application') {
      steps {
        echo " Packaing the Application"
        sh 'mvn clean package'
            }
    }
    
    stage('Publish Reports using HTML') {
      steps {
         publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/health-careapp/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
    }
    
    
	  stage('Docker Image Creation') {
      steps {
        sh 'docker build -t prafullla/healthcare-app:latest .'
            }
    }
   stage('DockerLogin') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
            }
        }
   }

 /*  stage('Push Image to DockerHub') {
      steps {
        sh 'docker push prafullla/healthcare-app:latest'
            }
    }*/
      /* stage ('Configure Test-server with Terraform, Ansible and then Deploying'){
           steps {
               dir('my-serverfiles'){
                sh 'sudo chmod 600 jenkinskey1.pem'
                sh 'terraform init'
                sh 'terraform validate'
               sh 'terraform apply --auto-approve'
                }
            }
        }*/
    /* stage('Deploy application using ansible'){
               steps {
                 ansiblePlaybook credentialsId: 'test-server1', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'ansible-playbook.yml'
                   } 
            } 
     }*/
}
