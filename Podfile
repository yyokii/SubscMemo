# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'SubscMemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SubscMemo
  pod 'Firebase/Auth'
  pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  pod 'CombineFirebase/Firestore'
  pod 'CombineFirebase/Auth'
  pod "Resolver"

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
  end
end
