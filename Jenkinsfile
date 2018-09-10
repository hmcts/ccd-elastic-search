#!groovy
@Library("Infrastructure") _

properties([
        parameters([
                string(name: 'PRODUCT_NAME', defaultValue: 'ccd', description: ''),
                choice(name: 'ENVIRONMENT', choices: 'saat\nsprod\nsandbox', description: 'Environment where code should be build and deployed'),
                booleanParam(name: 'PLAN_ONLY', defaultValue: true, description: 'set to true for skipping terraform apply'),
                booleanParam(name: 'BUILD_LOGSTASH_IMAGE', defaultValue: false, description: 'set to true to build a new Logstash image')
        ])
])

productName = params.PRODUCT_NAME
environment = params.ENVIRONMENT
planOnly = params.PLAN_ONLY

withInfrastructurePipeline(productName, environment, planOnly, 'sandbox') {
}
