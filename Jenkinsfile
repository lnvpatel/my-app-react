pipeline {
    agent any
    tools {
        nodejs 'NodeJs'
    }
    environment {
        CODEDEPLOY_APP_NAME = 'Oriserve_web'
        CODEDEPLOY_DEPLOY_GROUP = 'oriserve_deployment_group'
        AWS_CREDENTIALS = 'AWS_JENKINS' // Jenkins AWS credentials ID
        AWS_REGION = 'ap-south-1'
        S3_BUCKET_NAME = 'oriservereact'
        LOCAL_FILE_PATH = "${WORKSPACE}/build.zip" // Path to the local build artifact
        S3_FILE_PATH = 'build.zip' // Path in S3 bucket
    }
    stages {
        stage('Install Yarn') {
            steps {
                script {
                    sh 'npm install -g yarn'
                }
            }
        }
        
        stage('Clean Up') {
            steps {
                script {
                    sh 'yarn cache clean'
                    sh 'rm -rf node_modules'
                    sh 'rm -rf yarn.lock'
                    sh 'rm -rf build'
                }
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh 'yarn install'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'yarn build'
                }
            }
        }

        stage('Package') {
            steps {
                script {
                    // Create the zip file of the build directory
                    sh'''
                         cd build
                         zip -r ../build.zip .
                      '''
                }
            }
        }

        stage('Upload to S3') {
            steps {
                script {
                    withAWS(credentials: "${AWS_CREDENTIALS}", region: "${AWS_REGION}") {
                        sh '''
                            aws s3 cp ${LOCAL_FILE_PATH} s3://${S3_BUCKET_NAME}/${S3_FILE_PATH} --region ${AWS_REGION}
                        '''
                    }
                }
            }
        }

        stage('Deploy to CodeDeploy') {
            steps {
                script {
                    withAWS(credentials: "${AWS_CREDENTIALS}", region: "${AWS_REGION}") {
                        sh '''
                            aws deploy create-deployment \
                                --application-name ${CODEDEPLOY_APP_NAME} \
                                --deployment-group-name ${CODEDEPLOY_DEPLOY_GROUP} \
                                --deployment-config-name CodeDeployDefault.AllAtOnce \
                                --description "Deploying React App from S3" \
                                --file-exists-behavior OVERWRITE \
                                --revision revisionType=S3,s3Location={bucket=${S3_BUCKET_NAME},key=${S3_FILE_PATH},bundleType=zip}
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment was successful!'
        }
        failure {
            echo 'Deployment failed. Check logs for details.'
        }
    }
}
