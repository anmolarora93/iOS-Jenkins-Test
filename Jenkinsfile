node {
    stage('Checkout') {
        checkout([$class: 'GitSCM', branches: [[name: '*/$branch']], 
            doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], 
            userRemoteConfigs: [[credentialsId:'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' , url: 'https://github.com/anmolarora93/iOS-Jenkins-Test']]])
    }
    stage('Environment/Bundles Setup') {
    }
    stage('Clean') {
    }
    stage('Code Sign') {
        method = "development"
        match(readonly: true, type: method)
    }
    stage('Create Build') {   
        scheme = "Image Picker"
        configuration = "Debug"
        export_method = "development"
        icloud_environment = "Production"
        gym(scheme: scheme, configuration: configuration, export_options:export_options, output_name:"Image Picker.ipa")
    }
}
