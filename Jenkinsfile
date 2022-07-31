
pipeline {
    agent any


    stages {
        stage('Test') {
            steps {
                sh 'echo test'
                // sh('ls -lrth')
               sh '''
               cd setter; terraform init;
               terraform plan --out setter.binary;
               terraform show -json setter.binary > ./setter.json;
               pip3 install checkov
               checkov -f ./setter.json;

               cd ../;
               cd getter; terraform init;
               terraform plan --out getter.binary;
               terraform show -json getter.binary > ./getter.json;
               checkov -f ./getter.json;
               cd ../;
               '''
            
            }
        }
        stage('Build & Deploy') {
            steps {
               echo 'building and deploying!!'
            //    sh("cd setter && terraform apply --auto-approve && cd ../ && cd getter && terraform apply --auto-approve")
              
            }
        }
        }
    }