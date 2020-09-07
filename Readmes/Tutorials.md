# Tutorial

In Tutti, a `Tutorial` is a single or multi page onboarding guide. It is intended to show more information than a short `hint` and is perfect for a single- or multi page guide.

The `Tutorial` base class is a simple data carrier that specifies a set of `pages`.

You can create your own custom tutorial types by inheriting the `Tutorial` base class.


## Creating a tutorial

This is the most basic way to create a tutorial:

```swift
let page1 = TutorialPage(title: "Page 1", text: "Text 1", imageName: "image1")
let page2 = TutorialPage(title: "Page 2", text: "Text 2", imageName: "image2")
let page3 = TutorialPage(title: "Page 3", text: "Text 3", imageName: "image3")
let tutorial = Tutorial(pages: [page1, page2, page3])
```

As you can see, the tutorial itself just specifies data. To present it, you should use a presenter.


## Localized tutorials

You can use `LocalizedTutorial` to automatically create a tutorial based on localized strings.

```swift
let tutorial = LocalizedTutorial(id: "welcome")
```

This will cause the tutorial to resolve pages based on a bunch of parameters.

Localized tutorials are really powerful and requires very little setup. Check out the docs for more information and the demo to see it in practice.


## Presenting a tutorial

In Tutti, tutorials are just data carriers that know nothing about how they are to be presented.

To present a tutorial, you can use a `tutorial presenter`, for instance:

```swift
let presenter = TutorialViewController()
presenter.present(tutorial: tutorial, in: self, from: view)
```

Tutti currently comes with a single built-in tutorial presenter:

* `TutorialViewController` - Presents tutorials in a horizontal page controller.

You can create your own presenters by implementing the `TutorialPresenter` protocol.

Tutti currently has no SwiftUI-based presenters. I will add some in the future.


## Connecting a tutorial to an onboarding

In Tutti, tutorials are just data carriers and presenters are only responsible for presenting tutorials. In order to combine this with smart logic, you must also use an [onboarding][Onboarding] of some kind. 

The onboarding will then be responsible for the behavior of the onboarding experience, the presenter for how a tutorial is presented and the tutorial for the content.

You can check the onboarding whether it should be presented or not:

```swift
let onboarding = Onboarding(id: "welcome")
guard onboarding.shoulBePresented else { return }
let presenter = TutorialViewController()
presenter.present(tutorial: tutorial, in: self, from: view)
onboarding.registerPresentation()
```

`HintPresenter` provides you with a `tryPresent` function that streamlines this setup:

```swift
let onboarding = Onboarding(id: "welcome")
onboarding.tryPresent(hint) {
    let presenter = TutorialViewController()
    presenter.present(tutorial: tutorial, in: self, from: view)
}
```

`tryPresent` checks whether or not an `Onboarding` should be presented. If so, the presentation block will be triggered and `tryPresent` will register the presentation.


[Onboarding]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Onboarding.md
