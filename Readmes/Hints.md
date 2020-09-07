# Hints

In Tutti, a `Hint` is a short onboarding message, that is intended to be displayed briefly to tell users about important parts of your app.

The `Hint` base class is a simple data carrier that specifies a `title`, a `text` and an `image`.

You can create your own custom hint types by inheriting the `Hint` base class.


## Creating a hint

This is the most basic way to create a hint:

```swift
let hint = Hint(
    title: "Welcome!", 
    text: "This button is new!")
```

As you can see, the hint itself just specifies data. To present it, you should use a presenter.


## Presenting a hint

In Tutti, hints are just data carriers that know nothing about how they are to be presented.

To present a hint, you can use a `hint presenter`:

```swift
let presenter = CalloutHintPresenter()
presenter.present(hint: hint, in: self, from: view)
```

Tutti comes with a couple of built-in hint presenters:

* `AlertHintPresenter` - Presents hints in a regular `UIAlertController`.
* `CalloutHintPresenter` - Presents hints in a callout bubble. You can style these callouts to great extent. Have a look at the demo.

You can create your own presenters by implementing the `HintPresenter` protocol.

Tutti currently has no SwiftUI-based presenters. I will add some in the future.


## Connecting a hint to an onboarding

In Tutti, hints are just data carriers and presenters are only responsible for presenting hints. In order to combine this with smart logic, you must also use an [onboarding][Onboarding] of some kind. 

The onboarding will then be responsible for the behavior of the onboarding experience, the presenter for how a hint is presented and the hint for the content.

You can check the onboarding whether it should be presented or not:

```swift
let onboarding = Onboarding(id: "welcome")
guard onboarding.shoulBePresented else { return }
let presenter = CalloutHintPresenter()
presenter.present(hint: hint, in: self, from: view)
onboarding.registerPresentation()
```

`HintPresenter` provides you with a `tryPresent` function that streamlines this setup:

```swift
let onboarding = Onboarding(id: "welcome")
onboarding.tryPresent(hint) {
    let presenter = CalloutHintPresenter()
    presenter.present(hint: hint, in: self, from: view)
}
```

`tryPresent` checks whether or not an `Onboarding` should be presented. If so, the presentation block will be triggered and `tryPresent` will register the presentation.


[Onboarding]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Onboarding.md
