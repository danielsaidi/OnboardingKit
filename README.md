<p align="center">
    <img src="Resources/Icon.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/OnboardingKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-6.0-orange.svg" alt="Swift 6.0" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <a href="https://danielsaidi.github.io/OnboardingKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <img src="https://img.shields.io/github/license/danielsaidi/OnboardingKit" alt="MIT License" />
</p>



# OnboardingKit

OnboardingKit is a Swift & SwiftUI SDK that helps you create amazing onboarding experiences, with control over the presentation state of each onboarding.

<p align="center">
    <img src="https://github.com/danielsaidi/OnboardingKit/releases/download/8.0.0/Demo.gif" width=350 />
</p>

OnboardingKit has different onboarding types. A standard ``Onboarding`` is shown at once, and only once, while other types can require multiple presentation attempts, a certain number of "incorrect" actions, etc.

OnboardingKit has localized utilities, like the ``LocalizedOnboarding``, and UI components like ``OnboardingPageView`` and ``OnboardingSlideshow``.



## Installation

OnboardingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/OnboardingKit.git
```



## Getting started

In OnboardingKit, an `Onboarding` determines the state and behavior of an onboarding experience. You can use various onboarding types to get different behaviors. 

The code below shows how to use a standard onboarding to present a first launch onboarding sheet:

```swift
import OnboardingKit
import SwiftUI

struct ContentView: View {

    @State
    private var isOnboardingPresented: Bool
    
    private let onboarding = Onboarding(id: "welcome") 

    var body: some View {
        Text("Hello, world")
            .task(tryPresentOnboarding)
            .sheet(isPresented: $isOnboardingPresented) {
                ...
            }
    }
    
    func tryPresentOnboarding() {
        onboarding.tryPresent { 
            isOnboardingPresented = true
        }
    }
}
```

The onboarding will honor its own rules and remember any previous presentation, so `tryPresent` will only trigger when it makes sense for the onboarding.

See the online [getting started guide][Getting-Started] for more information.



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has an app that lets you explore the library.



## Support my work 

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][OpenSource].

Your support makes it possible for me to put more work into these projects and make them the best they can be.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]



## License

OnboardingKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://www.danielsaidi.com
[GitHub]: https://www.github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Mastodon]: https://mastodon.social/@danielsaidi
[Twitter]: https://twitter.com/danielsaidi

[Documentation]: https://danielsaidi.github.io/OnboardingKit
[Getting-Started]: https://danielsaidi.github.io/OnboardingKit/documentation/onboardingkit/getting-started
[License]: https://github.com/danielsaidi/OnboardingKit/blob/master/LICENSE
