#!groovy
@Library("Infrastructure") _

properties([
        parameters([
                string(name: 'PRODUCT_NAME', defaultValue: 'ccd', description: ''),
                choice(name: 'ENVIRONMENT', choices: 'saat\nsprod\nsandbox', description: 'Environment where code should be build and deployed'),
                booleanParam(name: 'DEPLOY_ES_CLUSTER', defaultValue: true, description: 'set to true to deploy a new ElasticSearch cluster')
        ])
])

productName = params.PRODUCT_NAME
environment = params.ENVIRONMENT

withInfrastructurePipeline(productName, environment, 'sandbox')
