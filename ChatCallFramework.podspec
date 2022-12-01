Pod::Spec.new do |spec|

 spec.name         = "ChatCallFramework"
   spec.version      = "1.0.0"
     spec.requires_arc = true
   spec.summary      = "This is chat and call framework"
   spec.description  = "Framework for chat and call module"
  spec.homepage     = "https://github.com/ambucognome/ChatFramework"
  spec.license      = "MIT"
  spec.author       = { "Ambu Sangoli" => "ambu@cognome.in" }
  spec.platform     = :ios, "14.0"
  spec.source       = { :git => "https://github.com/ambucognome/ChatFramework.git", :tag => spec.version.to_s }
    #spec.source_files  = "ChatFramework/**/**"
        spec.source_files = "ChatFramework/**/*.{swift}"
        spec.resources = "ChatFramework/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
    
    spec.framework  = "UIKit"
    spec.dependency "JitsiMeetSDK", "5.1.0"
    spec.dependency "Socket.IO-Client-Swift", "~> 15.2.0"
    spec.dependency "SwiftyJSON"
    spec.dependency "Kingfisher"
    spec.dependency "NotificationBannerSwift", "~> 3.0.0"
    spec.dependency "PlaceholderUITextView"
    
    spec.swift_version = "5.5.1"
end
