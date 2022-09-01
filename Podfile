platform :ios, ‘11.0’

inhibit_all_warnings!
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end


target 'Dropbox_Test' do
  
  use_modular_headers!
  use_frameworks!

  pod 'SwiftyDropbox'

end
