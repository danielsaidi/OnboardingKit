<p align="center">
    <img src ="Resources/Logo.png" width="400" />
</p>

<p align="center">
    <a href="https://github.com/danielsaidi/Tutti">
        <img src="https://badge.fury.io/gh/danielsaidi%2FTutti.svg?style=flat" alt="Version" />
    </a>
    <img src="https://api.travis-ci.org/danielsaidi/Tutti.svg" alt="Build Status" />
    <a href="https://cocoapods.org/pods/Tutti">
        <img src="https://img.shields.io/cocoapods/v/Tutti.svg?style=flat" alt="CocoaPods" />
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/carthage-supported-green.svg?style=flat" alt="Carthage" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/Tutti.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-4.2-orange.svg" alt="Swift 4.2" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About Tutti

Tutti is a Swift library that can be used to handle user onboarding expericences.
It lets you create quick hints as well as single- or multi-screen tutorials.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>

Tutti will display a certain hint/tutorial once per app install. This means that
even if you tell Tutti to show a tutorial/hint every time an app starts, it will
only be shown once. 

You can also tell Tutti to show a tutorial/hint once for every user, e.g. when a
new user logs in. Just set the `userId` parameter to the current user's id/name.


## Install

### CocoaPods

Add this to your `Podfile` then run `pod install`. Remember to use the generated
workspace afterwards.

```
pod 'Tutti'
```

Remember to use the generated workspace (not the project file) after installing.

### Carthage

Add this to your `Cartfile`, run `carthage update` then add the framework to the
app from `Carthage/Build`:

```
github "danielsaidi/Tutti"
```

Once the update completes, link in the built framework from `Carthage/Build`.

### Manual

To add `Tutti` to your app without using Carthage or CocoaPods, first clone this
repo and place it somewhere in the project folder. Then add `Tutti.xcodeproj` to
your project, select your app target then add the Tutti framework as an embedded
binary under `General` and as a target dependency under `Build Phases`.


## Example Application

This repository contains an example app. To try it our, open the `Tutti` project
and run the `TuttiExample` target to try different types of hints and tutorials.


## Example Code

Below are some basic ways to create hints and tutorials with `Tutti`. In a large
application, you'll probably want to use localized strings and keep track of the
available hints and tutorials using an IoC framework, but here is the most basic
way to set it up:


```swift
func createStandardHint(for userId: String?) -> Hint {
    return StandardHint(
        identifier: "hint", 
        title: "Hint, hint!", 
        text: "This is a quick hint. It will only be displayed once.", 
        userId: userId)
}

func createStandardTutorial(for userId: String?) -> Tutorial {
    return StandardTutorial(
        identifier: "standard", 
        pageCount: 2,
        userId: userId)
}

/* 

In Localizable.strings, add this to support the standard tutorial:
    "tutorial_standard_0_title" = "Page 1 title";
    "tutorial_standard_0_text" = "Page 1 text";
    "tutorial_standard_1_title" = "Page 2 title";
    "tutorial_standard_1_text" = "Page 2 text";

*/

func createLocalizedTutorial(for userId: String?) -> Tutorial {
    return LocalizedTutorial(
        identifier: "localized", 
        userId: userId)
}

/* 

In Localizable.strings, add this to setup the localized tutorial with 2 pages:
    "tutorial_localized_0_title" = "Page 1 title";
    "tutorial_localized_0_text" = "Page 1 text";
    "tutorial_localized_1_title" = "Page 2 title";
    "tutorial_localized_1_text" = "Page 2 text";

*/
```

These are just some ways to create hints and tutorials. Check out the example to
see some more examples.

To present a hint/tutorial, just create a strongly referenced presenter and tell
it to present the hint/tutorial as such:

```swift
self.hintPresenter = CalloutHintPresenter()     // Remember a strong reference!
let alreadyPresented = !hintPresenter.present(hint: hint, in: self, from: view)

self.tutPresenter = TutorialViewController(nibName: nil, bundle: nil)   // Strong!
let alreadyPresented = !tutPresenter.present(tutorial: tutorial, in: self, from: view)
```

Tutti comes with two built-in hint presenters and one tutorial presenter:

### AlertHintPresenter

This primitive hint presenter will present hints in a regular `UIAlertController`
alert. You should probably not use it, but what the hell do I know of your needs?

### CalloutHintPresenter

This presenter presents hints in callout bubbles that point at the source views.
You can style these bubbles to great extent, changing everything from colors and
fonts to how they are animated. Have a look [this styling guide](Appearance) and
replace `EasyTipView` with `CalloutView`.

### TutorialViewController

This tutorial presenter presents tutorials in a modal view controller that takes
over the entire screen. To use it, just add a `TutorialViewController.xib` and a
`TutorialViewControllerCell.xib` to your app and set'em up the way you want them
to look. The `TutorialViewController` class comes with some outlets, but you can
subclass it and add as many outlets and triggers as you want.


## Contact me

I hope you like this library. Feel free to reach out if you have questions or if
you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com](mailto:daniel.saidi@gmail.com)
* Twitter: [@danielsaidi](http://www.twitter.com/danielsaidi)
* Web site: [danielsaidi.com](http://www.danielsaidi.com)


## License

Tutti is available under the MIT license. See LICENSE file for more info.



[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/

[Appearance]: https://github.com/teodorpatras/EasyTipView/#-customising-the-appearance-