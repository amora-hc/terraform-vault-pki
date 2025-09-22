pipelineJob('PKI Operations List Certificates') {
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
            scriptPath('jenkins/pipelines/pki_operations_list_certificates/Jenkinsfile')
        }
    }
}