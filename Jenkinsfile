pipeline {
  agent {
    label 'master'
  }

  stages {
    stage('git') {
      steps {
        git 'https://github.com/Krishna-Kumar-Santhanam/node-js-sample.git'
      }
    }

    stage ('build') {
      steps {
        sh 'docker build -t test-image .'
        sh 'docker tag test-image:latest "account-id".dkr.ecr.us-east-1.amazonaws.com/test-image:tag'
      }
    }

    stage ('Push to AWS ECR') {
      steps {
        sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "account-id".dkr.ecr.us-east-1.amazonaws.com'
        sh 'docker push "account-id".dkr.ecr.us-east-1.amazonaws.com/test-image:tag'
      }
    }

    stage ('K8s deploy') {
      steps {
        withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'K8s', namespace: '', serverUrl: '') {
          sh 'kubectl apply -f node.yaml'
        }
      }
    }
  }
}
