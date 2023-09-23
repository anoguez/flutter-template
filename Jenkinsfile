pipeline {
    agent { label 'macos' }

    // parameters { }

    environment {
        LC_ALL = 'en_US.UTF-8'
        LANG = 'en_US.UTF-8'
        LANGUAGE = 'en_US.UTF-8'

        APP_NAME = "Runner"
        APP_IDENTIFIER = "com.ngz.flutter_template"

        APP_STORE_CONNECT_API_KEY_KEY = credentials('ITC_AUTH_KEY')
    }

    options {
        skipDefaultCheckout(true)
    }

    stages {

        stage('Starting') {
            steps {
                echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
                echo "Test ${APP_STORE_CONNECT_API_KEY_KEY}"
            }
        }

        stage('Git Checkout') {
            steps {
                echo 'Checkouting Project...'
                checkout scm
            }
        }

        // stage('Git - Fetch Version/Commits') {
        //     steps {
        //         script {
        //             env.GIT_COMMIT_MSG = sh(returnStdout: true, script: '''
        //             git log -1 --pretty=%B ${GIT_COMMIT}
        //             ''').trim()

        //             env.BUILD_NUMBER_XCODE = sh(returnStdout: true, script: '''
        //             echo $(xcodebuild -target "${APP_TARGET}" -configuration "${APP_BUILD_CONFIG}" -showBuildSettings  | grep -i 'CURRENT_PROJECT_VERSION' | sed 's/[ ]*CURRENT_PROJECT_VERSION = //')
        //             ''').trim()

        //             env.BUNDLE_SHORT_VERSION = sh(returnStdout: true, script: '''
        //             echo $(xcodebuild -target "${APP_TARGET}" -configuration "${APP_BUILD_CONFIG}" -showBuildSettings  | grep -i 'MARKETING_VERSION' | sed 's/[ ]*MARKETING_VERSION = //')
        //             ''').trim()

        //             env.APP_BUNDLE_IDENTIFIER = sh(returnStdout: true, script: '''
        //             echo $(xcodebuild -target "${APP_TARGET}" -configuration "${APP_BUILD_CONFIG}" -showBuildSettings  | grep -i 'PRODUCT_BUNDLE_IDENTIFIER' | sed 's/[ ]*PRODUCT_BUNDLE_IDENTIFIER = //')
        //             ''').trim()

        //             def DATE_TIME = sh(returnStdout: true, script: '''
        //             date +%Y.%m.%d-%H:%M:%S
        //             ''').trim()

        //             env.APP_BUILD_NAME = "${env.APP_NAME}-${env.BUILD_NUMBER}-Ver-${env.BUNDLE_SHORT_VERSION}-B-${env.BUILD_NUMBER_XCODE}-${DATE_TIME}"
        //             echo "Build Name: ${env.APP_BUILD_NAME}"

        //             env.GIT_BRANCH = sh(returnStdout: true, script: '''
        //             git name-rev --name-only HEAD
        //             ''').trim()
        //             echo "Branch name: ${env.BRANCH_NAME}"
        //             echo "Current Branch: ${env.GIT_BRANCH}"
        //         }
        //     }
        // }

        // stage('Unit Test cases') {
        //             steps {
        //                 script {
        //                         try {
        //                             sh """
        //                             #!/bin/bash
        //                             echo "Executing Fastlane test lane..."
        //                             ${ env.FASTLANE } tests
        //                             """
        //                         } catch(exc) {
        //                             currentBuild.result = "UNSTABLE"
        //                             error('There are failed tests.')
        //                         }
        //                     }
        //                 }
        //             post {
        //                     always {
        //                         junit(testResults: '**/reports/report.junit', allowEmptyResults: true)
        //                     }
        //                 }
        // }

        // stage('Quality checks - Report') {
        //     parallel {
        //         stage('Linting') {  }
        //         stage('Code Coverage') {  }
        // }

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

    }

    post {
        always {
            echo "Build completed with status: ${currentBuild.result}"
        }
    }
}