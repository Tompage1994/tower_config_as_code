def towerExists = true

pipeline {

  agent {
    dockerfile {
      args '-u root --privileged'
    }
  }


  stages {

    // stage ('Get latest code') {
    //   steps {
    //     checkout([$class: 'GitSCM', branches: [[name: '${branch}']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '${git_name}']], submoduleCfg: []])
    //   }
    // }

    stage ('Verify .tower exists') {
      steps {
        script {
          towerExists = false
          catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
            sh "ls ${git_name}/.tower"
            towerExists = true
          }
        }
      }
    }

    stage ('Display versions') {
      when { expression { towerExists }}
      steps {
        sh '''
          #!/bin/sh
          python -V
          ansible --version
          awx --version
        '''
      }
    }

    stage ('Pull dependencies') {
      when { expression { towerExists }}
      steps {
          sh '''
            #!/bin/sh
            ansible-galaxy install -f -r roles/requirements.yml
            ansible-galaxy collection install -f -r collections/requirements.yml
          '''
      }
    }

    stage ('Throw at Tower') {
      when { expression { towerExists }}
      steps {
        // withCredentials([string(credentialsId: 'ansible-vault', variable: 'VAULTPASS')]) {
        //   sh '''
        //     touch /tmp/vaultpass
        //     echo ${VAULTPASS} > /tmp/vaultpass
        //   '''
        // }
        sh '''
          #!/bin/sh
          ansible-playbook playbooks/seed.yml -e @${git_name}/.tower/tower_vars.yml
        '''
      }
    }

  }
}