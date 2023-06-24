pipeline {
    agent { label 'macos-agent' }

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
                sh 'cd ios/fastlane'
                sh 'fastlane beta'
            }
        }

        // post {}

    }
}