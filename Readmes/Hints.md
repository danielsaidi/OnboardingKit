# Hints

In Tutti, a `Hint` is a short onboarding message that is intended to be displayed briefly to tell the user about important (or non-important) parts of your app.

The `Hint` base class is a simple data carrier that specifies a `title` and a `text`. You can create your own custom hint types by inheriting the `Hint` base class.


## Creating a hint

This is the most basic way to create a hint:

```swift
let hint = Hint(
    title: "Welcome!", 
    text: "This button is new!")
```

As you can see, `Hint` has very basic data. Subclass it if you need it to carry more data.


## Presenting a hint

To present a hint, you can use a `HintPresenter`, for instance:

```swift
let presenter = CalloutHintPresenter()
presenter.present(hint: hint, in: self, from: view)
```

Tutti comes with a couple of built-in hint presenters:

* `AlertHintPresenter` presents hints in a regular `UIAlertController`.
* `CalloutHintPresenter` presents hints in a callout bubble. You can style these callouts to great extent. Have a look at the demo.

You can create your own presenters by implementing the `HintPresenter` protocol.

Tutti currently has no `SwiftUI` presenters.


## Connecting a hint to an onboarding

In Tutti, `hints` are data carriers and `presenters` are responsible for presenting hints. To determine the behavior or a hint, you need an [onboarding][Onboarding] of some kind.

To put it all together, first create an onboarding instance and check whether it should be presented or not:

```swift
let onboarding = Onboarding(id: "welcome")
guard onboarding.shoulBePresented else { return }
```

If so, you can create a hint and present it with any presenter you like:

```swift
let presenter = CalloutHintPresenter()
presenter.present(hint: hint, in: self, from: view)
onboarding.registerPresentation()
```

As you can see, the onboarding and the hint is completely separated, which means that the same logic can be reused when working with tutorials.

`HintPresenter` also has a `tryPresent` function that streamlines this setup:

```swift
let onboarding = Onboarding(id: "welcome")
onboarding.tryPresent(hint) {
    let presenter = CalloutHintPresenter()
    presenter.present(hint: hint, in: self, from: view)
}
```

`tryPresent` checks whether or not an `Onboarding` should be presented. If so, the presentation block will be triggered and `tryPresent` will register the presentation.


[Onboarding]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Onboarding.md
