# Run `pod lib lint Sheeeeeeeeet.podspec' to ensure this is a valid spec.

Pod::Spec.new do |s|
  s.name             = 'Tutti'
  s.version          = '2.0.1'
  s.summary          = 'Tutti is a Swift library for creating tutorials, hints and onboarding experiences.'

  s.description      = <<-DESC
Tutti is a Swift library that can be used to handle app tutorials and hints. You
can create multiscreen tutorials, hint callouts from views you want to highlight
as well as compose onboarding experiences for entire apps and/or single features.
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/Tutti'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/Tutti.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Tutti/**/*.swift'
end
