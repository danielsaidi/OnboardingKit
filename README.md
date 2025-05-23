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

OnboardingKit is SwiftUI SDK that helps you create amazing onboarding experiences on all major Apple platforms.

<p align="center">
    <img src="https://github.com/danielsaidi/OnboardingKit/releases/download/8.2.0/OnboardingKit-Demo.gif" width=350 />
</p>

OnboardingKit has different `Onboarding` types, powerful onboarding view components like ``OnboardingPageView`` and ``OnboardingSlideshow``, an ``OnboardingScreen`` that can wrap any onboarding flow, and much more.



## Installation

OnboardingKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/OnboardingKit.git
```


## Support My Work

By [becoming a sponsor][Sponsors], you directly support the development & improvement of my various [open-source projects][OpenSource]. 



## Getting started

OnboardingKit has various onboarding types and views that can be used to tailor an app's onboarding behavior. 

The various ``Onboarding`` types defines unique onboarding experience behaviors, for instance: 

* ``Onboarding`` is presented right away, and only once.
* ``ConditionalOnboarding`` is presented when a certain condition returns `true`.
* ``CorrectBehaviorOnboarding`` is presented when a user is not behaving as intended.
* ``DelayedOnboarding`` is presented after a certain number of presentation attempts.

OnboardingKit has views that can be used to present onboarding flows, as well as ways to handle page state.

* An ``OnboardingPageView`` can be used to show a set of pages in a horizontal page view. 
* An ``OnboardingSlideshow`` can be used to show a set of pages in a slideshow that auto-slides forward.
* An ``OnboardingScreen`` can be used to wrap any onboarding flow in a frame with additional controls.
* An ``OnboardingPageState`` can be used to manage page state for all views. 

All views support all major Apple platforms (iOS, macOS, tvOS, watchOS & visionOS).

See the online [getting started guide][Getting-Started] for more information.



## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The `Demo` folder has an app that lets you explore the library.



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
