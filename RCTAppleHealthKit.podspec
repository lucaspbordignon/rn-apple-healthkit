Pod::Spec.new do |s|
  s.name         = "RCTAppleHealthKit"
  s.summary      = "A React Native bridge module for interacting with Apple Healthkit data"
  s.version      = "0.6.5"
  s.homepage     = "https://github.com/terrillo/rn-apple-healthkit"
  s.license      = "MIT"
  s.author       = { "Terrillo Walls" => "terrillo@terrillo.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/terrillo/rn-apple-healthkit", :tag => "master" }
  s.source_files  = "RCTAppleHealthKit/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"

end