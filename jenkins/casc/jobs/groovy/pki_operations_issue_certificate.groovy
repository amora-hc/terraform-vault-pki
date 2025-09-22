pipelineJob('PKI Operations Issue Certificate') {
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
            scriptPath('jenkins/pipelines/pki_operations_issue_certificate/Jenkinsfile')
        }
    }
}