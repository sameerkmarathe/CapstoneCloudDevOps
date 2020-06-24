pipeline{
environment{
registry = "sameerm/capstone"
registryCredential = 'dockercred'

}
agent any
stages{

 stage('Lint') {
              steps {
                  sh 'hadolint Dockerfile'
                  sh 'tidy -q -e *.html'
              }
        }
stage('Build') {
              steps {
                  sh 'docker build --tag=timmlot/capstone .'
              }
         }
         stage('Upload image to Docker') {
              steps {
                script {
                  docker.withRegistry( '', registryCredential ) {
                    sh 'docker push timmlot/capstone'
                  }
                }
              }
         }
         stage('Deploy') {
              steps {
                  withAWS(region:'us-east-2',credentials:'aws-static') {
                  sh "aws eks --region us-west-2 update-kubeconfig --name udacity"
                  sh 'kubectl apply -f app.yml'
                  sh 'kubectl apply -f exposeapp.yml'
                  }
              }
         }



}






}
