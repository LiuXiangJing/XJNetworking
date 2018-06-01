Pod::Spec.new do |s|

  s.name         = "XJNetworking"
  s.version      = "1.0.0"
  s.summary      = "XJNetworking is an iOS request util based on AFNetworking and MJExtension"

  s.homepage     = "https://github.com/LiuXiangJing/XJNetworking.git"
  s.platform     = :ios, '7.0'
  s.license      = "MIT"

  s.author             = { "liuxj" => "lxj_tintin@126.com" }

  s.source       = { :git => "https://github.com/LiuXiangJing/XJNetworking.git", :tag => s.version.to_s }


  s.source_files  = "XJNetworking/**/*.{h,m}"
  s.requires_arc  = true
  s.ios.deployment_target = "7.0"
  s.framework = "CFNetwork"

  s.dependency "AFNetworking", "~> 3.2.1"
  s.dependency "MJExtension", "~> 3.0.13"
end
