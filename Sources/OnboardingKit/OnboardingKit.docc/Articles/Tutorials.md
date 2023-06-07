# Tutorials

In OnboardingKit, a ``Tutorial`` is a single- or multi-page guide that is intended to tell users about important (or non-important) features in your app.

The `Tutorial` base class is a simple data carrier that specifies a set of pages. You can create your own custom tutorial types by inheriting the `Tutorial` base class.



## Creating a tutorial

This is the most basic way to create a tutorial:

```swift
let tutorial = Tutorial(pages: [
    TutorialPage(title: "Page 1", text: "Text 1"),
    TutorialPage(title: "Page 2", text: "Text 2"),
    TutorialPage(title: "Page 3", text: "Text 3")
])
```

As you can see, the ``Tutorial`` base class has very limited data and just consists of a set of ``TutorialPage`` items. 

If you want a tutorial and its pages to carry more information, you can subclass both classes.

For instance, here we create a tutorial where each page has a URL:

```swift
let url = URL("http://dont-force-unwrap-in-real-life.com")!
let tutorial = Tutorial(pages: [
    UrlTutorialPage(title: "Page 1", text: "Text 1", url: url),
    UrlTutorialPage(title: "Page 2", text: "Text 2", url: url),
    UrlTutorialPage(title: "Page 3", text: "Text 3", url: url)
])
```

This means that you can create custom page types to fit your specific needs.


## Localized tutorials

You can use a ``LocalizedTutorial`` to automatically setup a tutorial with ``TutorialPage`` pages, based on localized strings.

```swift
let tutorial = LocalizedTutorial(id: "welcome")
```

You can then add pages in `Localizable.strings`:

```
"tutorial.welcome.0.title" = "Localized tutorials";
"tutorial.welcome.0.text" = "Localized tutorials resolve their own page count by looking at the available localized strings.\n\nYou can navigate through this tutorial by swiping left/right or by using the next/previous buttons.";
"tutorial.welcome.1.title" = "Automatic page count";
"tutorial.welcome.1.text" = "If you add or remove pages in Localizable.strings, this tutorial will automatically adjust its page count to the available translations.\n\nBy the way, did you notice that the buttons and page indicator changed as you switched page?";
"tutorial.welcome.2.title" = "That's it";
"tutorial.welcome.2.text" = "You have now seen all pages in this tutorial. Try adding more pages in the demo app to see how this tutorial changes. Remember to add new title images and translations.\n\nTap the close button to close this tutorial. It can not be shown again.";
```

This will cause the tutorial to resolve a ``TutorialPage`` items, based on a bunch of parameters.

Localized tutorials are really powerful and can save you a lot of work. Check out the docs for more information and the demo to see it in practice.


## Connecting a tutorial to an onboarding

In OnboardingKit, tutorials are just data carriers that can be used as they are, e.g. to create onboarding flows in SwiftUI. 

However, to determine the behavior of a tutorial, like when it should be presented, you need an onboarding. 

OnboardingKit comes with a few built-in onboarding types, like ``Onboarding``, ``DelayedOnboarding``, ``ConditionalOnboarding`` etc. where each type determines how the onboarding will behave.

To present a tutorial, first create an onboarding and check whether or not it should be presented:

```swift
let onboarding = Onboarding(id: "welcome")
guard onboarding.shouldBePresented else { return }
```

If so, you can create a tutorial, present it in any way then register the presentation:

```swift
let tutorial = Tutorial(pages: ...)
// Present the tutorial in some way
onboarding.registerPresentation()
```

Registering the presentation will have different effects on different onboarding types, where some will never be shown again, some will only be shown after a certain amount of tries etc.

You can also just use the onboarding's ``Onboarding/tryPresent(presentAction:)`` function to avoid these manual steps:

```swift
let onboarding = Onboarding(id: "welcome")
onboarding.tryPresent {
    let tutorial = Tutorial(pages: ...)
    // Present the tutorial
}
```

``Onboarding/tryPresent(presentAction:)`` checks whether or not the presentation should be performed, based on the onboarding type. If so, the presentation block will be triggered and the presentation will be registered.
