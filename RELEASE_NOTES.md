# Release Notes

There are no release notes before v`1.2.0`. For these versions, please check the
git tags. Also note that Tutti doesn't use semver. Breaking changes can occur on
minor version bumps, but not on revision bumps.



## 1.2.0

This is a pretty big update with some breaking changes. The most important thing
to be aware of, however, is that the decision making of whether or not a hint or
tutorial should be presented has been moved from the presenters to these classes.
This means that presenters are now only responsible for the actual presentation. 

This means that if you migrate to `1.2.0`, you must modify your code to call the
`present` function of your hints and tutorials, NOT your presenters. If you keep
using the presenters, your hints and tutorials will always be presented.


### New features:

- I have added a new `DeferredOnboarding` protocol. It lets you specify how many
times `present` must be called before a hint or tutorial is actually presented.

- The `Hint` and `Tutorial` protocols have new `present` functions, which should
be used from now on, if you want automated decision making to take place.

- I have added new `DeferredHint` and `DeferredTutorial` protocols, that inherit
the base protocols as well as `DeferredOnboarding`.

- I have added new `StandardDeferredHint` and `StandardDeferredTutorial` classes,
that inherit their standard base classes as well as the deferred protocols above.
They also have deferred-specific presentation logic.


### Breaking changes:

- The decision whether or not a hint/tutorial should be presented has been moved
from the presenters to the hint and tutorial classes. You must call the `present`
function of these classes instead of the presenters from now on, if you want the
display history to be honored.

- The presenter `present` functions don't have return values anymore, since they
will always present the provided hint/tutorial.