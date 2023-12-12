# ``OnboardingKit``

OnboardingKit helps you create onboarding experiences in `Swift` and `SwiftUI`.



## Overview

![OnboardingKit logo](Logo.png)

OnboardingKit has different onboarding types. Standard onboardings are shown right away, and only once, while other types can require multiple presentation attempts, a certain number of "incorrect" actions, etc. You can also combine different onboarding types to create new ones and reset the state of any onboarding to display it again. 

OnboardingKit supports multiple users, so that each onboarding is unique to each user.



## Installation

OnboardingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/OnboardingKit.git
```

If you prefer to no have external dependencies, you can also just copy the source code into your app.



## Getting started

The <doc:Getting-Started> article helps you get started with ApiKit.



## Repository

For more information, source code, etc., visit the [project repository][Repository].



## License

ApiKit is available under the MIT license. See the [LICENSE][License] file for more info.



## Topics

### Articles

- <doc:Getting-Started>
- <doc:Understanding-Onboardings>
- <doc:Understanding-Hints>
- <doc:Understanding-Tutorials>

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
- ``GenericTutorial``
- ``LocalizedTutorial``
- ``UrlTutorialPage``

### UI

- ``TutorialPageView``
- ``TutorialPageViewStyle``



[License]: https://github.com/danielsaidi/OnboardingKit/blob/master/LICENSE
[Repository]: https://github.com/danielsaidi/OnboardingKit
