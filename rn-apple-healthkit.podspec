require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name             = 'rn-apple-healthkit'
  s.version          = package['version']
  s.summary          = package['description']
  s.license          = package['license']
  s.homepage         = package['homepage']
  s.authors          = 'Matthias Nehlsen'
  s.platforms        = { :ios => "9.0" }
  s.source           = { :git => 'https://github.com/matthiasn/rn-apple-healthkit.git', :tag => "v#{s.version}" }
  s.source_files     = 'RCTAppleHealthKit/*.{h,m}'
  s.requires_arc     = true
  #s.dependency 'React'
end
