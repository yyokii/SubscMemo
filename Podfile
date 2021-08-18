# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'SubscMemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SubscMemo
  pod 'CombineFirebase/Firestore'
  pod 'CombineFirebase/Auth'
  pod 'Firebase/Auth'
  pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
  pod 'Firebase/Messaging'
  pod 'FirebaseFirestoreSwift', '> 7.0-beta'
  pod 'Google-Mobile-Ads-SDK'
  pod "Resolver"
  
  target 'SubscMemoTests' do
    inherit! :search_paths
    
    pod 'Firebase'
  end
end

target 'SubscMemoWidget' do
  use_frameworks!
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
