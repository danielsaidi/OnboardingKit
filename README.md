<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="OnboardingKit Logo" title="OnboardingKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/OnboardingKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift 5.9" />
    <img src="https://img.shields.io/github/license/danielsaidi/OnboardingKit" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>


## About OnboardingKit

OnboardingKit helps you create onboarding expericences like hints and tutorials in `Swift` and `SwiftUI`. 

The result can look like this, or completely different:

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>

OnboardingKit has different onboarding types. Standard onboardings are shown right away, and only once, while other types can require multiple presentation attempts, a certain number of "incorrect" actions, etc. You can also combine different onboarding types to create new ones and reset the state of any onboarding to display it again. 

OnboardingKit supports multiple users, so that each onboarding is unique to each user.



## Installation

OnboardingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/OnboardingKit.git
```

If you prefer to no have external dependencies, you can also just copy the source code into your app.



## Getting started

In OnboardingKit, an ``Onboarding`` determines the state and behavior of an onboarding experience, while a `Hint` is a short onboarding message and a `Tutorial` is a page-based onboarding flow.

You can use various `Onboarding` types to get different behaviors. 

The code below shows how to use a standard onboarding to present a hint or tutorial:

```swift
import OnboardingKit
import SwiftUI

struct ContentView: View {

    @State
    private var isOnboardingPresented: Bool 
    
    private let tutorial = LocalizedTutorial(id: "welcome")

    var body: some View {
        Text("Hello, world")
            .onAppear(tryPresentOnboarding)
            .sheet(isPresented: $isOnboardingPresented) {
                TutorialPageView(tutorial: tutorial)
            }
    }
    
    func tryPresentOnboarding() {
        let onboarding = Onboarding(id: "welcome")
        onboarding.tryPresent { 
            // Present the hint, for instance in a toast or a callout
            let hint = Hint(title: "Welcome!", text: "Welcome to this app.")
            // ...or, present a tutorial
            isOnboardingPresented = true
            // ...or do anything you want
        }
    }
}
```

As you can see in the code above, the onboarding holds the state and behavior, while the presentation block defines what should happen.

For more information, please see the [online documentation][Documentation] and [getting started guide][Getting-Started].



## Documentation

The [online documentation][Documentation] has more information, code examples, etc.



## Demo Application

The demo app lets you explore the library on iOS and macOS. To try it out, just open and run the `Demo` project.



## Support my work 

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][GitHub].



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
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/OnboardingKit/documentation/onboardingKit/
[Getting-Started]: https://danielsaidi.github.io/OnboardingKit/documentation/onboardingKit/getting-started
[License]: https://github.com/danielsaidi/OnboardingKit/blob/master/LICENSE
