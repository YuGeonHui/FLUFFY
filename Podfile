# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'FLUFFY' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FLUFFY
pod 'Alamofire'
pod 'Then'
pod 'RxSwift'
pod 'RxCocoa'
pod 'RxGesture'
pod 'PanModal'
pod 'SwiftRichString'
pod 'FSCalendar'

post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
           end
      end
    end
  end
end
