#
# Be sure to run `pod lib lint KLCommonTools.podspec' to ensure this is a
# valid spec before submitting.
#/Users/zl/Desktop/ray/KLCommonTools/KLCommonTools/Example/KLCommonTools.xcodeproj
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'KLCommonTools'
    s.version          = '0.4.8'
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
    
    #s.source_files = 'KLCommonTools/Classes/**/*.{h,m}'
    
    s.default_subspec = ['Configure','Category','Others']
    
    # 基础依赖
    s.subspec 'Configure' do |ss|
        ss.source_files     = 'KLCommonTools/Classes/Configure/**/*'
    end
    #category
    s.subspec 'Category' do |ss|
        ss.source_files     = 'KLCommonTools/Classes/Category/**/*'
        ss.dependency 'KLCommonTools/Configure'
    end
    
    s.subspec 'Others' do |ss|
        ss.source_files     = 'KLCommonTools/Classes/Others/**/*'
        ss.dependency 'KLCommonTools/Configure'
     end
    
    s.subspec 'Progress' do |ss|
           ss.source_files     = 'KLCommonTools/Classes/Progress/**/*'
           ss.dependency 'KLCommonTools/Configure'
           ss.dependency 'MBProgressHUD', '~> 0.9.2'#依赖库
       end
    
    s.subspec 'WebView' do |ss|
        ss.source_files     = 'KLCommonTools/Classes/WebView/**/*.{h,m}'
    end
    
    s.subspec 'TableView' do |ss|
          ss.source_files     = 'KLCommonTools/Classes/TableView/**/*.{h,m}'
          ss.dependency 'KLCommonTools/Category'

      end
    
    s.subspec 'ImageScroll' do |ss|
        ss.source_files     = 'KLCommonTools/Classes/ImageScroll/**/*.{h,m}'
        ss.dependency 'Masonry'
        ss.dependency 'SDWebImage'

    end
    
    
    
    #  s.subspec 'Tool' do |ss|
    #ss.source_files     = 'KLCommonTools/Classes/Tool/**/*'
    #子文件夹的写法（一定要把父文件夹的source_files给注释掉）
    # ss.subspec 'Define' do |defi|
    #     defi.source_files =  'KLCommonTools/Classes/Tool/Define/**/*'
    # end
    #  end
    
 
 # s.resource = 'KLCommonTools/Assets/*.bundle'

     s.resource_bundles = {
    'KLCommonTools' => ['KLCommonTools/Assets/*']
 }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    #s.libraries = 'c++','xml2' #  该pod依赖的系统资源文件
    
    #s.dependency 'MBProgressHUD', '~> 0.9.2'
end
