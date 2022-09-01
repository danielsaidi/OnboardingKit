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

In Tutti, hints are just data carriers. To determine the behavior of a hint, you need an onboarding. Tutti comes with various onboarding types, like ``Onboarding``, ``DelayedOnboarding`` etc.

To present a hint, first create an onboarding and check whether or not it should be presented:

```swift
let onboarding = Onboarding(id: "welcome")
guard onboarding.shoulBePresented else { return }
```

If so, you can create a hint, present it in any way then register the presentation:

```swift
let hint = Hint(title: "Welcome!", text: "Welcome to this app.")
// Present the hint in some way
onboarding.registerPresentation()
```

You can also just use the onboarding's ``Onboarding/tryPresent(presentAction:)`` function to avoid all these manual steps:

```swift
let onboarding = Onboarding(id: "welcome")
onboarding.tryPresent { 
   // Present the hint
}
```

`tryPresent` checks whether or not the onboarding should be presented. If so, the presentation block will be triggered and the presentation will be registered.
