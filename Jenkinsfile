#!groovy

@Library('Infrastructure') _

properties([
        parameters([
                string(name: 'PRODUCT_NAME', defaultValue: 'ccd', description: ''),
                string(name: 'ENVIRONMENT', defaultValue: 'db-sandbox', description: 'Suffix for resources created'),
                choice(name: 'SUBSCRIPTION', choices: 'sandbox\nprod\nnonprod', description: 'Azure subscriptions available to build in'),
                booleanParam(name: 'PLAN_ONLY', defaultValue: true, description: 'set to true for skipping terraform apply'),
                booleanParam(name: 'BUILD_LOGSTASH_IMAGE', defaultValue: false, description: 'set to true to build a new Logstash image')
        ])
])

productName = params.PRODUCT_NAME
environment = params.ENVIRONMENT
subscription = params.SUBSCRIPTION
planOnly = params.PLAN_ONLY

node {
    env.PATH = "$env.PATH:/usr/local/bin"
    def az = { cmd -> return sh(script: "env AZURE_CONFIG_DIR=/opt/jenkins/.azure-$subscription az $cmd", returnStdout: true).trim() }
    stage('Checkout') {
        deleteDir()
        checkout scm
    }
}