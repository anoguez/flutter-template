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

                dir("/ios/fastlane") {
                    sh "pwd"
                    sh 'fastlane beta'
                }
                
            }
        }

        // post {}

    }
}