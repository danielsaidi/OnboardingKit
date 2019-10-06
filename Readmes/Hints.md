# Hints

Tutti comes with a set of built-in hint types that can be used for different purposes. 

* `StandardHint` - A basic hint with no specific behavior.
* `DeferredHint` - Requires a certain number of presentation attempts before it is presented.
* `CorrectBehaviorHint` - Can be used to show a hint when a user is not behaving as intended.

You can also create your own custom hint types by implementing the `Hint` protocol.


## Creating a hint

This is the most basic way to create a hint:

```swift
func createHint(for userId: String?) -> Hint {
    StandardHint(
        identifier: "hint", 
        title: "This is a hint!", 
        text: "This hint will only be displayed once.", 
        userId: userId)
}
```

In a large app, you may want to use localized strings and have a more sophisticated setup. Check out the demo app for more examples.


## Presenting a hint

Hints are just data carriers. They don't know anything about how they are to be presented. To present a hint, you'll use a `hint presenter`, for instance:

```swift
self.presenter = CalloutHintPresenter()     // You must keep a strong reference!
presenter.present(hint: hint, in: self, from: view)
```

This will only have an effect if the hint can actually be presented. This means that you don't have to keep track of if a certain hint has been presented or not. Tutti will handle this for you.


## Hint presenters

Tutti comes with a couple of built-in hint presenters:

* `AlertHintPresenter` - Presents hints in a regular `UIAlertController`. You should probably not use it in production apps, since it's not a good experience.
* `CalloutHintPresenter` - This is a copy of `EasyTipView` and presents hints in a callout bubble. You can style these callouts to great extent. Have a look [this styling guide][Appearance] and replace `EasyTipView` with `CalloutView`.

You can also create your own custom presented by implementing the `HintPresenter` protocol.


[Appearance]: https://github.com/teodorpatras/EasyTipView/#-customising-the-appearance-