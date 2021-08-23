  pipeline {
    agent any
    environment {
    AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
  }
    stages {
      stage('TF Init&Plan') {
        steps {
          sh '/Users//dsachdev/Terraform/terraform init'
          sh '/Users//dsachdev/Terraform/terraform plan'
        }      
      }

      stage('Approval') {
        steps {
          script {
            def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
          }
        }
      }

      stage('TF Apply') {
        steps {
          sh '/Users//dsachdev/Terraform/terraform apply -auto-approve'
        }
      }
    } 
  }
