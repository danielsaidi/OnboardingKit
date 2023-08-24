# ``OnboardingKit``

OnboardingKit helps you create onboarding expericences in `Swift` and `SwiftUI`.



## Overview

![OnboardingKit logo](Logo.png)

OnboardingKit has different onboarding types. A standard onboarding is shown right away and only once, while other types can require multiple presentation attempts, a certain number of "incorrect" actions etc. You can also combine different onboarding types to create new ones and reset the state of any onboarding you want to display again. 

OnboardingKit supports multiple users, so that each onboarding is unique to each user.

OnboardingKit supports `iOS 13`, `macOS 10.15`, `tvOS 13` and `watchOS 6`.



## Installation

OnboardingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/OnboardingKit.git
```

If you prefer to no have external dependencies, you can also just copy the source code into your app.



## Repository

For more information, source code, and to report issues, sponsor the project etc., visit the [project repository](https://github.com/danielsaidi/OnboardingKit).



## About this documentation

The online documentation is currently iOS only. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.



## License

OnboardingKit is available under the MIT license.



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
- ``TutorialPageInfo``
- ``LocalizedTutorial``
- ``UrlTutorialPage``

### UI

- ``TutorialPageView``
- ``TutorialPageViewStyle``
