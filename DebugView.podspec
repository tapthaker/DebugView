Pod::Spec.new do |s|
  s.name         = "DebugView"
  s.version      = "0.0.2"
  s.summary      = "A simple way to debug your view hierarchy."
  s.description  = <<-DESC
                    It adds borders to your views, shows their frame sizes and shows the class name that they belong to.
                   DESC

  s.homepage     = "https://github.com/thegreatloser/DebugView"
  s.screenshots  = "https://raw.githubusercontent.com/thegreatloser/DebugView/master/screenshot1.png", "https://raw.githubusercontent.com/thegreatloser/DebugView/master/screenshot2.png"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Tapan Thaker" => "tapan.d.thaker@gmail.com" }
  s.social_media_url   = "http://twitter.com/tapthaker"
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/thegreatloser/DebugView.git", :tag => "0.0.2" }
  s.source_files  = "Source"
  s.framework    = 'UIKit'
  s.requires_arc = true

end
