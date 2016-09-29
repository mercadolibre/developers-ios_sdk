#
#  Be sure to run `pod spec lint MeliDevSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "MeliDevSDK"
  s.version      = "0.1.0"
  s.summary      = "The official iOS SDK for MercadoLibre's Platform."
  s.homepage     = "http://developers.mercadolibre.com/"
  s.license      = "MIT"
  s.author       = { "Ignacio Giagante" => "igiagante@gmail.com" }
  s.source       = { :git => 'https://github.com/mercadolibre/developers-ios_sdk', :tag => s.version.to_s }

  s.platform     = :ios, "8.0"
  s.requires_arc = true
  
  s.source_files = "LibraryComponents/Classes/**/*.{h,m}"
  s.resources    = "LibraryComponents/**/*.xib", "LibraryComponents/Assets/**/*.xcassets", "LibraryComponents/Assets/**/*.plist", "LibraryComponents/Assets/**/*.ttf"

end
