pipelineJob('PKI Operations CDS Workflow') {
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
            scriptPath('jenkins/pipelines/pki_operations_cds_workflow/Jenkinsfile')
        }
    }
}