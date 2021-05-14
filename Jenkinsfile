node {
    stage('Checkout') {
        checkout([$class: 'GitSCM', branches: [[name: '*/$branch']], 
            doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], 
            userRemoteConfigs: [[credentialsId:'/$githubToken' , url: 'gihub project url']]])
    }
    stage('Environment/Bundles Setup') {
        sh "Scripts/change_server.sh $server"
        sh "pod install --repo-update"
    }
    stage('Clean') {
        clear_derived_data()
        sh("rm -rf Image\ Picker*zip")
        sh("rm -rf ~/Library/Developer/Xcode/Archives/*")
    }
    stage('Code Sign') {
        method = "development"
        match(readonly: true, type: method)
    }
    stage('Create Build') {   
        scheme = "Image\ Picker"
        configuration = "Debug"
        export_method = "development"
        icloud_environment = "Production"
        gym(scheme: scheme, configuration: configuration, export_options:export_options, output_name:"Image\ Picker.ipa")
    }
}
