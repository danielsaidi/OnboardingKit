# Onboarding

In Tutti, the `Onboarding` class is at the core of the onboarding logic. It can be used to apply different onboarding rules and is what determines whether or not a hint or tutorial should be presented.

Tutti comes with a set of built-in onboarding types that can be used for different purposes. 

* `Onboarding` - This base class can be used when a hint or tutorial should be presented once.
* `ConditionalBehaviorOnboarding` - Can be used to show a hint when a certain condition is active.
* `CorrectBehaviorOnboarding` - Can be used to show a hint when a user is not behaving as intended.
* `DelayedOnboarding` - Requires a certain number of presentation attempts before a hint or tutorial is presented.

You can create your own onboarding types by inheriting the `Onboarding` base class.


## Onboarding vs. Hint and Tutorial

In Tutti, `Onboarding` defines an experience and determines how it should behave. Hints and tutorials can then be presented if an `onboarding` should be presented.

In other words, `Onboarding` specifies the rules that apply to the experience, while `Hint` and `Tutorial` can be presented as a result of the onboarding experience.

The [hint][Hints] and [tutorial][Tutorials] guides describe in more details how to present hints and tutorials.


[Hints]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Hints.md
[Tutorials]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Tutorials.md
