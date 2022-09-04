# ``Tutti``

Tutti helps you create onboarding expericences like hints and tutorials.



## Overview

![Tutti logo](Logo.png)

Tutti has different onboarding types that can be presented as hints or tutorials. A standard onboarding is shown right away and only once, while other types require multiple presentation attempts, a certain number of "incorrect" actions etc. 

Tutti has different onboarding types. A standard onboarding is shown right away and only once, while other types can require multiple presentation attempts, a certain number of "incorrect" actions etc. You can also combine different onboarding types to create new ones and reset the display state of any onboarding if you want to display it again. 

Tutti also supports multiple users, so that each onboarding is unique to each user.



## Supported Platforms

Tutti supports `iOS 9`, `macOS 10.15`, `tvOS 13` and `watchOS 6`.



## Installation

Tutti can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/Tutti.git
```

or with CocoaPods:

```
pod Tutti
```

You can also clone the repository and build the library locally.


## About this documentation

The online documentation is currently iOS-specific. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.

Note that DocC currently omits extensions, which means that some extensions are missing. Future versions will aim to improve this.



## License

Tutti is available under the MIT license.



## Topics

### Articles

- <doc:Getting-Started>
- <doc:Onboardings>
- <doc:Hints>
- <doc:Tutorials>

### Onboarding

- ``Onboarding``
- ``ConditionalOnboarding``
- ``CorrectBehaviorOnboarding``
- ``DelayedOnboarding``

### Hints

- ``Hint``

### Tutorials

- ``Tutorial``
- ``TutorialPage``
- ``LocalizedTutorial``
- ``UrlTutorialPage``
