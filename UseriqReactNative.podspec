require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "UseriqReactNative"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  UseriqReactNative
                   DESC
  s.homepage     = "https://github.com/author/UseriqReactNative"
  s.license      = "MIT"
  s.author       = { "Aravind G S" => "aravind.gs@useriq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/UseriqReactNative.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency "UserIQ"
end

  
