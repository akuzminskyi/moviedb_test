source 'https://github.com/CocoaPods/Specs.git'
target 'MovieDB' do
    platform :ios, '10.0'
    use_frameworks!
    pod 'Reusable', '~> 4.0'

    target 'MovieDBTests' do
        inherit! :search_paths
        pod 'Nimble'
        pod 'Quick'
    end
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
