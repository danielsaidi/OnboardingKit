# Run `pod lib lint OnboardingKit.podspec' to ensure this is a valid spec.

Pod::Spec.new do |s|
  s.name             = 'OnboardingKit'
  s.version          = '6.1.2'
  s.swift_versions   = ['5.6']
  s.summary          = 'OnboardingKit is a Swift library for creating tutorials, hints and onboarding experiences.'

  s.description      = <<-DESC
OnboardingKit is a Swift library that can be used to handle app tutorials and hints.
You can create multiscreen tutorials, hint callouts from views you want to highlight
as well as compose onboarding experiences for entire apps and/or single features.
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/OnboardingKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/OnboardingKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.swift_version = '5.6'
  s.ios.deployment_target = '13.0'
  s.macos.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  s.source_files = 'Sources/OnboardingKit/**/*.swift'
end
