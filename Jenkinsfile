
pipeline {
    agent any


     parameters {
    string(name: 'DOCKER_IMAGE', defaultValue: 'si3mshady/blockchain-uber-clone:1')
    string(name: 'HELM_CHART', defaultValue: 'uber')
    string(name: 'CLUSTER_NAME', defaultValue: 'elliotteks')
    string(name: 'REGION', defaultValue: 'us-west-2')
  }
  	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}

    stages {
        stage('Build') {
            steps {
                echo 'Building docker image.'
              sh('echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin')
              sh('docker build . -t ${DOCKER_IMAGE}') // sudo chmod 777 /var/run/docker.sock 
              sh('docker push  ${DOCKER_IMAGE}')
            }
        }
        stage('Test') {
            steps {
                echo 'Test with TF plan...'
                sh('cd tf_deployment/ && terraform init && terraform plan')
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                // sh('cd tf_deployment/ && terraform apply --auto-approve')
                // sh('cd tf_deployment/ && terraform destroy --auto-approve')
                sh('aws eks update-kubeconfig --name ${CLUSTER_NAME} --region ${REGION}')
                // sh('helm install ${HELM_CHART} ${HELM_CHART}')
                sh('helm upgrade ${HELM_CHART} ${HELM_CHART}')
            }
        }
    }