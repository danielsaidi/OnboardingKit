# Understanding Tutorials

In OnboardingKit, a ``Tutorial`` is a single- or multi-page guide that is intended to welcome users to your app, or inform them about new features.

The ``Tutorial`` base class is a basic data carrier that specifies a set of pages. You can create custom tutorial types by inheriting the base class and adding your own state and logic.



## How to create a tutorial

This is the most basic way to create a tutorial:

```swift
let tutorial = Tutorial(
    pages: [
        TutorialPage(title: "Page 1", text: "Text 1"),
        TutorialPage(title: "Page 2", text: "Text 2"),
        TutorialPage(title: "Page 3", text: "Text 3")
    ]
)
```

The base ``Tutorial`` type has very limited amount of data and just defines a few ``TutorialPage`` items. 

You can subclass both the tutorial type and the pages it contains, for instance:

```swift
let url = URL(string: "http://dont-force-unwrap-in-real-life.com")!
let tutorial = UrlTutorial(
    pages: [
        UrlTutorialPage(title: "Page 1", text: "Text 1", url: url),
        UrlTutorialPage(title: "Page 2", text: "Text 2", url: url),
        UrlTutorialPage(title: "Page 3", text: "Text 3", url: url)
    ],
    readMoreUrl: URL(string: "http://realy-dont.com")! 
)
```

This means that you can create custom tutorial and page types to fit your specific needs.



## Localized tutorials

You can use a ``LocalizedTutorial`` to automatically create ``TutorialPage`` pages based on localized strings.

You create a localized tutorial with a unique id:

```swift
let tutorial = LocalizedTutorial(id: "welcome")
```

You then add pages to `Localizable.strings` like this:

```
"tutorial.welcome.0.title" = "Localized tutorials";
"tutorial.welcome.0.text" = "Localized tutorials resolve their own page count by looking at the available localized strings.\n\nYou can navigate through this tutorial by swiping left/right or by using the next/previous buttons.";
"tutorial.welcome.1.title" = "Automatic page count";
"tutorial.welcome.1.text" = "If you add or remove pages in Localizable.strings, this tutorial will automatically adjust its page count to the available translations.\n\nBy the way, did you notice that the buttons and page indicator changed as you switched page?";
"tutorial.welcome.2.title" = "That's it";
"tutorial.welcome.2.text" = "You have now seen all pages in this tutorial. Try adding more pages in the demo app to see how this tutorial changes. Remember to add new title images and translations.\n\nTap the close button to close this tutorial. It can not be shown again.";
```

The tutorial will then automatically create its pages based on a bunch of parameters.

Localized tutorials are powerful and can be configured in many ways. They can save you a lot of work.



## How to connect a tutorial to an onboarding

To determine the behavior of a tutorial, like when it should be presented, you need an onboarding. 

You can read more about onboarding types in <doc:Understanding-Onboardings>.

To present a tutorial, first create an onboarding instance and a tutorial:

```swift
let onboarding = Onboarding(id: "welcome")
let tutorial = Tutorial(pages: ...)
```

You can now use ``Onboarding/tryPresent(presentAction:)``, which will use the selected onboarding type's specific behavior to determine if it should be presented:   

```swift
onboarding.tryPresent {
    // Present the tutorial, for instance in a sheet
}
```

You can also just use the onboarding's other properties and functions to get full control over the presentation:

```swift
func tryPresentTutorial() {
    guard onboarding.shouldBePresented else { return }
    // Present the tutorial in some way
    onboarding.registerPresentation()
}
```

Registering the presentation (which is also done by `tryPresent`) will have different effects on different onboarding types. Some will never be shown again, while some will be shown again, if the user keeps behaving in a certain way.
