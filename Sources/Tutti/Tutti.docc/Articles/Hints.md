# Hints

In Tutti, a ``Hint`` is a short onboarding message that is intended to be displayed briefly, e.g. in a toast, callout bubble etc.


## Creating a hint

This is the most basic way to create a hint:

```swift
let hint = Hint(
    title: "Welcome!", 
    text: "This button is new!")
```

As you can see, ``Hint`` has very basic data. Subclass it if you need it to carry more data.


## Connecting a hint to an onboarding

In Tutti, hints are just data carriers that can be used as they are, e.g. to create onboarding experiences in SwiftUI. 

However, to determine the behavior of a hint, like when it should be presented, you need an onboarding.

Tutti comes with a few built-in onboarding types, like ``Onboarding``, ``DelayedOnboarding``, ``ConditionalOnboarding`` etc. where each type determines how the onboarding will behave.

To present a hint, first create an onboarding and check whether or not it should be presented:

```swift
let onboarding = Onboarding(id: "welcome")
guard onboarding.shouldBePresented else { return }
```

If so, you can create a hint, present it in any way then register the presentation:

```swift
let hint = Hint(title: "Welcome!", text: "Welcome to this app.")
// Present the hint in some way
onboarding.registerPresentation()
```

Registering the presentation will have different effects on different onboarding types, where some will never be shown again, some will only be shown after a certain amount of tries etc.

You can also just use the onboarding's ``Onboarding/tryPresent(presentAction:)`` function to avoid these manual steps:

```swift
let onboarding = Onboarding(id: "welcome")
onboarding.tryPresent { 
   // Present the hint
}
```

``Onboarding/tryPresent(presentAction:)`` checks whether or not the presentation should be performed, based on the onboarding type. If so, the presentation block will be triggered and the presentation will be registered.
