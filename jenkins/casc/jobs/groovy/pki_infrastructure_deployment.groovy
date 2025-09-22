pipelineJob('PKI Infrastructure Deployment') {
    description('Pipeline job from SCM')
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/amora-hc/terraform-vault-pki.git')
                    }
                    branch('main')
                }
            }
            scriptPath('jenkins/pipelines/pki_infrastructure_deployment/Jenkinsfile')
        }
    }
}
