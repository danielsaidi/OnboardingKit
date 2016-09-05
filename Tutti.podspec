Pod::Spec.new do |s|
  s.name             = 'Tutti'
  s.version          = '0.2.1'
  s.summary          = 'Tutti can be used to create iOS tutorials and onboarding experieces.'

  s.description      = <<-DESC
Tutti is a Swift library that can be used to create iOS tutorials and onboarding experieces.
It is currently limited to the functionality I need in my own iOS apps.

                       DESC

  s.homepage         = 'https://github.com/danielsaidi/Tutti'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/Tutti.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Tutti/Classes/**/*'
end
