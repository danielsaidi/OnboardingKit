<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="OnboardingKit Logo" title="OnboardingKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/OnboardingKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift 5.9" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/danielsaidi/OnboardingKit" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>



## About OnboardingKit

OnboardingKit is a Swift SDK that helps you create great onboarding experiences in `Swift` and `SwiftUI`.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>

OnboardingKit has different onboarding types. Standard onboardings are shown right away, and only once, while other types can require multiple presentation attempts, a certain number of "incorrect" actions, etc. 

You can combine different onboarding types to create new ones and reset the state of any onboarding to display it again. OnboardingKit supports multiple users.



## Installation

OnboardingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/OnboardingKit.git
```



## Getting started

In OnboardingKit, an `Onboarding` determines the state and behavior of an onboarding experience. You can use various onboarding types to get different behaviors. 

The code below shows how to use a standard onboarding to present a first launch onboarding tutorial:

```swift
import OnboardingKit
import SwiftUI

struct ContentView: View {

    @State
    private var isOnboardingPresented: Bool
    
    private let onboarding = Onboarding(id: "welcome") 
    private let tutorial = LocalizedTutorial(id: "welcome")

    var body: some View {
        Text("Hello, world")
            .task(tryPresentOnboarding)
            .sheet(isPresented: $isOnboardingPresented) {
                TutorialPageView(tutorial: tutorial, ...)
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

For more information, please see the [getting started guide][Getting-Started].



## Documentation

The [online documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The demo app lets you explore the library. To try it out, just open and run the `Demo` project.



## Support my work 

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][OpenSource].

Your support makes it possible for me to put more work into these projects and make them the best they can be.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [danielsaidi.com][Website]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]
* Twitter: [@danielsaidi][Twitter]
* E-mail: [daniel.saidi@gmail.com][Email]



## License

OnboardingKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com

[Website]: https://www.danielsaidi.com
[GitHub]: https://www.github.com/danielsaidi
[Twitter]: https://www.twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi
    
[Documentation]: https://danielsaidi.github.io/OnboardingKit/documentation/onboardingkit/
[Getting-Started]: https://danielsaidi.github.io/OnboardingKit/documentation/onboardingkit/getting-started

[License]: https://github.com/danielsaidi/OnboardingKit/blob/master/LICENSE
