# Hints

In Tutti, a `Hint` is a short onboarding message that is intended to be displayed briefly, e.g. in a toast, callout bubble etc.


## Creating a hint

This is the most basic way to create a hint:

```swift
let hint = Hint(
    title: "Welcome!", 
    text: "This button is new!")
```

As you can see, `Hint` has very basic data. It can be subclassed to create more complex or specialized hints.


## Hint presenters

To present a hint, you can use a `HintPresenter`.

`Tutti` doesn't come with any built-in presenters.

You can create your own presenters by implementing the `HintPresenter` protocol.

Have a look at the demo for examples.


## Connecting a hint to an onboarding

In Tutti, `hints` are data carriers and `presenters` are responsible for presenting hints. 

To determine the behavior, you need an [onboarding][Onboarding] of some kind.

Without a presenter, first create an onboarding and check whether or not it should be presented:

```swift
let onboarding = Onboarding(id: "welcome")
guard onboarding.shoulBePresented else { return }
```

If so, you can create a hint, present it and register the presentation with the onboarding:

```swift
let hint = Hint(title: "Welcome!", text: "Welcome to this app.")
// Present the hint
onboarding.registerPresentation()
```

If you use a `HintPresenter`, you can use `tryPresent` to avoid having to do all these manual steps:

```swift
let onboarding = Onboarding(id: "welcome")
let presenter = MyPresenter()
presenter.tryPresent(onboarding) { 
   // Present the hint
}
guard onboarding.shoulBePresented else { return }
```

`tryPresent` checks whether or not an `Onboarding` should be presented. If so, the presentation block will be triggered and the presentation will be registered.


[Onboarding]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Onboarding.md
