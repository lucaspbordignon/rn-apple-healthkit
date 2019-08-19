require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "RCTAppleHealthKit"
  s.summary      = "A React Native bridge module for interacting with Apple Healthkit data"
  s.version      = "0.6.5"
  s.homepage     = "https://github.com/terrillo/rn-apple-healthkit"
  s.license      = "MIT"
  s.author       = { "Terrillo Walls" => "terrillo@terrillo.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/stridekick/rn-apple-healthkit.git#24145673bc513abdb88c34d97b99ed72b477c219" }
  s.source_files  = "RCTAppleHealthKit/*.{h,m}"
  s.requires_arc = true
  s.dependency "React"
end
