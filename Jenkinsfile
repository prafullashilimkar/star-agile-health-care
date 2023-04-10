pipeline {
  agent any

  tools {
      maven 'M2_HOME'
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


          }
}
