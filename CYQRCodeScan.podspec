Pod::Spec.new do |s|
  s.name         = "CYQRCodeScan"
  s.version      = "1.0.4"
  s.summary      = "A simple QR Code scan solution"
  s.description  = <<-DESC
                    A simple QR Code scan solution with only system API and smooth animation.
                   DESC
  s.homepage     = "https://github.com/chenyun122/QRCodeScan"
  s.screenshots  = "https://github.com/chenyun122/QRCodeScan/raw/master/Screenshots/QRCodeScan.gif?raw=true"
  s.license      = "MIT"
  s.author             = { "Yun CHEN" => "chenyun122@gmail.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source       = { :git => "https://github.com/chenyun122/QRCodeScan.git", :tag => "#{s.version}" }
  s.source_files = "QRCodeScan", "QRCodeScan/**/*.{h,m}"
  s.resources    = "QRCodeScan/**/*.{xib,nib,storyboard,png}"
  s.resource_bundles = {
    'QRCodeScan' => ['QRCodeScan/**/*.xcassets','QRCodeScan/*.lproj/*']
  }
end
