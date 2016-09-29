#
#  Be sure to run `pod spec lint MeliDevSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "MeliDevSDK"
  s.version      = "0.0.1"
  s.summary      = "A short description of MeliDevSDK."
  s.homepage     = "http://EXAMPLE/MeliDevSDK"
  s.license      = "None"
  s.author             = { "Ignacio" => "igiagante@gmail.com" }
  s.platform     = :ios, "8.0"

  s.requires_arc = true
  s.homepage     = 'https://github.com/tonymillion/Reachability'
  s.source       = { :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v3.1.0' }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.homepage     = 'https://github.com/tonymillion/Reachability'
  s.source       = { :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v3.1.0' }
  s.source_files = "LibraryComponents/Classes/**/*.{h,m}"
  s.resources    = "LibraryComponents/**/*.xib", "LibraryComponents/Assets/**/*.xcassets", "LibraryComponents/Assets/**/*.plist", "LibraryComponents/Assets/**/*.ttf"

end
