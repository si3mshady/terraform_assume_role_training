
pipeline {
    agent any


    stages {
        stage('Test') {
            steps {
                sh 'echo test'
            //    sh '''
            //    cd setter; terraform init;
            //    terraform plan --out setter.binary;
            //    terraform show -json setter.binary > setter.json;
            //    checkov -f setter.json;

            //    cd ../;
            //    cd getter; terraform init;
            //    terraform plan --out getter.binary;
            //    terraform show -json getter.binary > getter.json;
            //    checkov -f getter.json;
            //    cd ../;
            //    '''
            
            }
        }
        stage('Build & Deploy') {
            steps {
               sh '''
               cd setter;
               docker run -i -t hashicorp/terraform:latest apply --auto-approve;

               cd ../;
               cd getter;
               docker run -i -t hashicorp/terraform:latest apply --auto-approve;
    
               '''
            }
        }
        }
    }