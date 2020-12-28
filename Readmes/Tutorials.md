# Tutorial

In Tutti, a `Tutorial` is a single- or multi-page onboarding guide that is intended to tell users about important (or non-important) features in your app.

The `Tutorial` base class is a simple data carrier that specifies a set of `pages`. You can create your own custom tutorial types by inheriting the `Tutorial` base class.


## Creating a tutorial

This is the most basic way to create a tutorial:

```swift
let page1 = TutorialPage(title: "Page 1", text: "Text 1", imageName: "image1")
let page2 = TutorialPage(title: "Page 2", text: "Text 2", imageName: "image2")
let page3 = TutorialPage(title: "Page 3", text: "Text 3", imageName: "image3")
let tutorial = Tutorial(pages: [page1, page2, page3])
```

As you can see, `Tutorial` has very basic data. Subclass it if you need it to carry more data.


## Localized tutorials

You can use a `LocalizedTutorial` to automatically setup a tutorial based on localized strings.

```swift
let tutorial = LocalizedTutorial(id: "welcome")
```

This will cause the tutorial to resolve pages based on a bunch of parameters.

Localized tutorials are really powerful and can save you a lot of work. Check out the docs for more information and the demo to see it in practice.


## Presenting a tutorial

To present a tutorial, you can use a `TutorialPresenter`, for instance:

```swift
let presenter = TutorialViewController()
presenter.present(tutorial: tutorial, in: self, from: view)
```

Tutti comes with a single built-in tutorial presenter:

* `TutorialViewController` presents tutorials in a horizontal page controller.

You can create your own presenters by implementing the `TutorialPresenter` protocol.

Tutti currently has no `SwiftUI` presenters.


## Connecting a tutorial to an onboarding

In Tutti, `tutorials` are data carriers and `presenters` are responsible for presenting tutorials. To determine the behavior or a tutorial, you need an [onboarding][Onboarding] of some kind.

To put it all together, first create an onboarding instance and check whether it should be presented or not:

```swift
let onboarding = Onboarding(id: "welcome")
guard onboarding.shoulBePresented else { return }
```

If so, you can create a tutorial and present it with any presenter you like:

```swift
let presenter = TutorialViewController()
presenter.present(tutorial: tutorial, in: self, from: view)
onboarding.registerPresentation()
```

As you can see, the onboarding and the tutorial is completely separated, which means that the same logic can be reused when working with hints.

`TutorialPresenter` provides you with a `tryPresent` function that streamlines this setup:

```swift
let onboarding = Onboarding(id: "welcome")
onboarding.tryPresent(tutorial) {
    let presenter = TutorialViewController()
    presenter.present(tutorial: tutorial, in: self, from: view)
}
```

`tryPresent` checks whether or not an `Onboarding` should be presented. If so, the presentation block will be triggered and `tryPresent` will register the presentation.


[Onboarding]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Onboarding.md
