# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GithubSearch' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GithubSearch
  # UI
  pod 'SnapKit'
  pod 'Reusable'
  
  # Reactive
  pod 'RxSwift'
  pod 'RxCocoa'
  
  # Architecture
  pod 'ReactorKit'
  
  # Networking
  pod 'Moya/RxSwift', '~> 15.0'
  
  # Utils
  pod 'Then'
end

# resolve compiler warning
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
