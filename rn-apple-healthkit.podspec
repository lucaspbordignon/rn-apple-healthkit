require "json"

json = File.read(File.join(__dir__, "package.json"))
package = JSON.parse(json).deep_symbolize_keys

Pod::Spec.new do |s|
  s.name = package[:name]
  s.version = package[:version]
  s.license = package[:license]
  s.authors = package[:author]
  s.summary = package[:description]
  s.homepage = package[:homepage]
  s.source = { :git => package[:homepage] }

  s.source_files  = "RCTAppleHealthKit/*.{h,m}"
  s.platform = :ios, "8.0"

  s.dependency 'React'
end
