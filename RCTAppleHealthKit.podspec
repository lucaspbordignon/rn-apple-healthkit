require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "RCTAppleHealthKit"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  RCTAppleHealthKit
                   DESC
  s.homepage     = "https://github.com/terrillo/rn-apple-healthkit"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author       = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/plahteenlahti/rn-apple-healthkit.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"
end

