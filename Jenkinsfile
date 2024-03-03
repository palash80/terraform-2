pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action: apply or destroy')
    }
    environment {
        REPO_URL = 'https://github.com/palash80/terraform-2.git'
        TERRAFORM_WORKSPACE = "/var/lib/jenkins/workspace/${JOB_NAME}"
        AWS_CREDENTIALS = credentials('aws')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }
    stages {
        stage('Clone Repository') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: "${REPO_URL}"]]])
            }
        } 
        stage('Terraform Init') {
            steps {
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform init --upgrade"
            }
        }
        stage('Validate Code') {
            steps {
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform validate"
            }
        }

        stage('Terraform Plan') {
            steps {
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform plan"
            }
        }
        stage('Approval For Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                input "Do you want to apply Terraform changes?"
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sh """
                    cd ${env.TERRAFORM_WORKSPACE}
                    terraform apply -auto-approve
                """       
            }
        }

        stage('Approval for Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                input "Do you want to Terraform Destroy?"
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                sh "cd ${env.TERRAFORM_WORKSPACE} && terraform destroy -auto-approve"
            }
        }
    }

    post {
        success {
            echo 'Succeeded!'
        }
        failure {
            echo 'Failed!'
        }
    }
}
