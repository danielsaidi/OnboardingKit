# Onboardings

In Tutti, an ``Onboarding`` is at the core of the onboarding experience and is what determines whether or not a hint or tutorial should be presented.

Tutti comes with a set of built-in onboarding types that can be used for different purposes. 

* ``Onboarding`` is presented right away, and only once.
* ``ConditionalOnboarding`` is presented when a certain condition returns `true`.
* ``CorrectBehaviorOnboarding`` is presented when a user is not behaving as intended.
* ``DelayedOnboarding`` - is presented after a certain number of presentation attempts.

You can create your own onboarding types by inheriting the `Onboarding` base class.


## Onboarding vs. Hint and Tutorial

In Tutti, an ``Onboarding`` defines the rules and behavior of an onboarding experience. A ``Hint`` or ``Tutorial`` can then be presented if the onboarding should be presented.

The hints and tutorials articles below describe in more details how to present hints and tutorials.


## Multi-user onboarding

You can specify a unique `userId` string when you create an `Onboarding`. 

If you do, the onboarding experience will be unique for that user and all presentation memory reset for each new user.
