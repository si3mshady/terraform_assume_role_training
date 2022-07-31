
pipeline {
    agent any


     parameters {
    
  }
  	

    stages {
        stage('Build') {
            steps {
                echo 'Building docker image.'
            
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
}
            // aws eks update-kubeconfig --name elliotteks --region us-west-2
//  aws eks delete-nodegroup --cluster-name elliotteks --nodegroup-name elliotts-eks-workernodes --region us-west-2