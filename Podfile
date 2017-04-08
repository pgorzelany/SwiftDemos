source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'

use_frameworks!

inhibit_all_warnings!

pod 'GPUImage','~>0.1.7'

target 'SwiftDemos' do

end

target 'SwiftDemosTests' do

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
