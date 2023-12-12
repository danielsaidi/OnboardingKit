# Understanding Hints

In OnboardingKit, a ``Hint`` is a short onboarding message that is intended to be displayed briefly, e.g. in a toast, callout bubble etc.

The ``Hint`` base class is a basic data carrier that defines some text properties. You can create custom hint types by inheriting the base class and adding your own state and logic.



## How to create a hint

This is the most basic way to create a hint:

```swift
let hint = Hint(title: "Welcome!",  text: "Here's something new!")
```

The base ``Hint`` type has very limited amount of data. You can subclass it if you need it to contain more data.



## How to connect a hint to an onboarding

To determine the behavior of a hint, like when it should be presented, you need an onboarding.

You can read more about onboarding types in <doc:Understanding-Onboardings>.

To present a hint, first create an onboarding instance and a hint:

```swift
let onboarding = Onboarding(id: "welcome")
let hint = Hint(title: "Welcome!", text: "Welcome to this app.")
```

You can now use ``Onboarding/tryPresent(presentAction:)``, which will use the selected onboarding type's specific behavior to determine if it should be presented:   

```swift
onboarding.tryPresent {
    // Present the hint, for instance in a toast or a callout
}
```

You can also just use the onboarding's other properties and functions to get full control over the presentation:

```swift
func tryPresentHint() {
    guard onboarding.shouldBePresented else { return }
    // Present the hint in some way
    onboarding.registerPresentation()
}
```

Registering the presentation (which is also done by `tryPresent`) will have different effects on different onboarding types. Some will never be shown again, while some will be shown again, if the user keeps behaving in a certain way.
