pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['nonprod', 'prod'], description: 'Select the environment')
        choice(name: 'REGION', choices: ['ap-south-1', 'us-east-1'], description: 'Select the AWS Region')
        choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Terraform Action')
    }

    environment {
        AWS_DEFAULT_REGION = "${params.REGION}"
    }

    stages {
        stage('Set AWS Credentials') {
            steps {
                script {
                    def credsId = (params.ENVIRONMENT == 'prod') ? 'aws-creds-prod' : 'aws-creds-nonprod'
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: credsId]]) {
                        env.AWS_ACCESS_KEY_ID = "${AWS_ACCESS_KEY_ID}"
                        env.AWS_SECRET_ACCESS_KEY = "${AWS_SECRET_ACCESS_KEY}"
                    }
                }
            }
        }

        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/pranaychinnam/terraform-aws-my-modules.git'
            }
        }
        stage('Terraform Init') {
            steps {
                dir("terraform/${params.ENVIRONMENT}") {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("terraform/${params.ENVIRONMENT}") {
                    script {
                        if (params.ACTION == 'destroy') {
                            bat "terraform plan -destroy -var='region=${params.REGION}'"
                        } else {
                            bat "terraform plan -var='region=${params.REGION}'"
                        }
                    }
                }
            }
        }

        stage('Terraform Apply/Destroy') {
            when {
                expression { return params.ACTION == 'apply' || params.ACTION == 'destroy' }
            }
            steps {
                input message: "Proceed with ${params.ACTION} on ${params.ENVIRONMENT}?"
                dir("terraform/${params.ENVIRONMENT}") {
                    script {
                        if (params.ACTION == 'destroy') {
                            bat "terraform destroy -auto-approve -var='region=${params.REGION}'"
                        } else if (params.ACTION == 'apply') {
                            bat "terraform apply -auto-approve -var='region=${params.REGION}'"
                        }
                    }
                }
            }
        }
    }
}
