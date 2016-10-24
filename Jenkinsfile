#!groovy

node {
    properties([
        pipelineTriggers([
            pollSCM('@weekly')
        ])
    ])

    def deployable_branches = ["master"]
    if (deployable_branches.contains(env.BRANCH_NAME)) {
        env.DOCKER_USE_HUB = 1
    }

    stage('Checkout') {
        checkout scm
    }

    stage('Build') {
        echo "Branch is: ${env.BRANCH_NAME}"
        echo "Build is: ${env.BUILD_NUMBER}"
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerbot',
                          usernameVariable: 'DOCKER_USERNAME', 
                          passwordVariable: 'DOCKER_PASSWORD']]) {
            timestamps {
                wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
                    sh('./build.sh')
                }
            }
        }
    }
}
