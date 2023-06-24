pipeline {
    agent { label 'macos' }

    environment {
        APP_NAME = "Runner"
    }

    stages {

        stage('Git Checkout') {
            steps {
                echo 'Checkouting Project...'
                checkout scm
            }
        }

        stage('Build') { 
            steps {
                echo 'Building Project...'

                sh "pwd"
                dir("./ios/fastlane") {
                    sh "pwd"
                    sh 'fastlane beta'
                }
                
            }
        }

        // post {}

    }
}