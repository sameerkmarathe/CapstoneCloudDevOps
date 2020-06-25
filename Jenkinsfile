pipeline{
environment{
registry = "sam2g/capstone"
registryCredential = 'dockercred'

}
agent any
stages{

 stage('Lint HTML and docker') {
              steps {
                  sh 'hadolint Dockerfile'
                  sh 'tidy -q -e *.html'
              }
        }
stage('Build docker') {
              steps {
                  sh 'docker build --tag=sam2g/capstone .'
              }
         }
         stage('Image upload to Docker') {
              steps {
                script {
                  docker.withRegistry( '', registryCredential ) {
                    sh 'docker push sam2g/capstone'
                  }
                }
              }
         }
         stage('Deploy image to EKS') {
              steps {
                  withAWS(region:'us-east-2',credentials:'aws-static') {
                  sh "aws eks --region us-east-2 update-kubeconfig --name udacitycapstone"
                  sh 'kubectl apply -f website.yml'
                  sh 'kubectl apply -f exposewebsite.yml'
                  }
              }
         }

}

}
