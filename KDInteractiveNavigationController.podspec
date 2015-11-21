Pod::Spec.new do |s|

  s.name         = "KDInteractiveNavigationController"
  s.version      = "0.0.1"
  s.summary      = "A short description of KDInteractiveNavigationController."

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/kingiol/KDInteractiveNavigationController"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "kingiol" => "kingxiaokang@gmail.com" }
  s.social_media_url   = "http://twitter.com/kingiol"

  s.platform     = :ios, "7.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/kingiol/KDInteractiveNavigationController", :tag => s.version.to_s }

  s.source_files  = "Classes/*.swift"
  s.frameworks = ['UIKit']
end
