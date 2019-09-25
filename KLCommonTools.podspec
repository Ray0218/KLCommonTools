#
# Be sure to run `pod lib lint KLCommonTools.podspec' to ensure this is a
# valid spec before submitting.
#/Users/zl/Desktop/ray/KLCommonTools/KLCommonTools/Example/KLCommonTools.xcodeproj
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KLCommonTools'
  s.version          = '0.1.2'
  s.summary          = 'A short description of KLCommonTools.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Ray0218/KLCommonTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ray0218' => 'ray_ios@163.com' }
  s.source           = { :git => 'https://github.com/Ray0218/KLCommonTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  #s.source_files = 'KLCommonTools/Classes/**/*'

# 基础依赖
s.subspec 'Configure' do |ss|
ss.source_files     = 'KLCommonTools/Classes/Configure/*'
end
#category
s.subspec 'Category' do |ss|
ss.source_files     = 'KLCommonTools/Classes/Category/*'
ss.dependency 'KLCommonTools/Configure'
end

s.subspec 'Others' do |ss|
ss.source_files     = 'KLCommonTools/Classes/Others/*'
ss.dependency 'KLCommonTools/Configure'
ss.dependency 'MBProgressHUD', '~> 0.9.2'#依赖库
end



  
  # s.resource_bundles = {
  #   'KLCommonTools' => ['KLCommonTools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  #s.dependency 'MBProgressHUD', '~> 0.9.2'
end
