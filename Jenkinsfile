#!groovy
@Library("Infrastructure") _

properties([
        parameters([
                string(name: 'PRODUCT_NAME', defaultValue: 'ccd', description: ''),
                choice(name: 'ENVIRONMENT', choices: 'saat\nsprod\nsandbox', description: 'Environment where code should be build and deployed'),
                booleanParam(name: 'BUILD_LOGSTASH_IMAGE', defaultValue: false, description: 'set to true to build a new Logstash image')
        ])
])

productName = params.PRODUCT_NAME
environment = params.ENVIRONMENT

withInfrastructurePipeline(productName, environment, 'sandbox') {
}
