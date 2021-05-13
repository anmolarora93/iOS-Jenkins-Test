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
        sh 'fastlane clean_xcode'
    }
    stage('Code Sign') {
        sh 'fastlane codesign method:"development"'
    }
    stage('Create Build') {   
        sh 'fastlane create_build'
    }
}

lane :clean_xcode do |options|
  clear_derived_data()
  sh("rm -rf Hello\ World*zip")
  sh("rm -rf ~/Library/Developer/Xcode/Archives/*")
end

lane :code_sign do |options|
  method = "development"
  match(readonly: true,
            type: method)
end

lane :create_build do |options|
  scheme = "Hello\ World"
  configuration = "Debug"
  export_method = "development"
  icloud_environment = "Production"
  
  gym(scheme: scheme,
      configuration: configuration,
      export_options:export_options,
      output_name:"Hello\ World.ipa")
end
