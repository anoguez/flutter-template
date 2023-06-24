pipeline {
    agent { label 'macos-agent' }

    parameters {
    }

    environment {
        APP_NAME = "Runner"
        APP_IDENTIFIER=${APP_IDENTIFIER}

        APP_ID=${APP_ID}
        ITC_TEAM_ID=${ITC_TEAM_ID}
        DEV_TEAM_ID=${DEV_TEAM_ID}

        APP_STORE_CONNECT_API_KEY_KEY_ID=${APP_STORE_CONNECT_API_KEY_KEY_ID}
        APP_STORE_CONNECT_API_KEY_ISSUER_ID=${APP_STORE_CONNECT_API_KEY_ISSUER_ID}
        
        APP_STORE_CONNECT_API_KEY_KEY=${APP_STORE_CONNECT_API_KEY_KEY}

        # S3
        S3_BUCKET=${S3_BUCKET}
        S3_REGION=${S3_REGION}
        S3_ACCESS_KEY=${S3_ACCESS_KEY}
        S3_SECRET_ACCESS_KEY=${S3_SECRET_ACCESS_KEY}

        MATCH_PASSWORD=${MATCH_PASSWORD}
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