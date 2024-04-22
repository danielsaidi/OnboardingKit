# Release Notes

OnboardingKit honors semver.



## 7.0.1

### 🐛 Bug Fixes

* The custom onboarding page view style is now applied on appear, instead of as a task.



## 7.0

This version drastically simplifies the library and bumps the platform deployment targets to more modern platform versions.

Please see the docs and the demo for updated examples.

### 💡 Behavior changes

* `Onboarding` and its subclasses have been simplified.
* `Onboarding` is now based on `tryPresent` regardless of which class you use.

### 💥 Breaking changes

* All deprecated code has been removed.

* `Hint` has been removed.
* `Onboarding` no longer has a `userId` property.
* `Onboarding` no longer has a `hasBeenPresented` property.
* `Onboarding` no longer has a `registerPresentation` function.
* `OnboardingPageView` now takes page values instead of a tutorial.
* `Tutorial` has been removed and replaced with new onboarding views.



## 6.3.1

This version makes OnboardingKit work on visionOS.



## 6.3

This version bumps macOS to 11.

### ✨ New features

* `TutorialPageView` now supports macOS.



## 6.2

This version bumps Swift to 5.9.

This version (once again) makes the `Tutorial` type non-generic, and adds a `GenericTutorial` for the rare use-cases where a generic type is needed. This will once again make it possible to add static properties to the `Tutorial` type, to define app-specific values.  

### ✨ New features

* `GenericTutorial` can be used for generic use-cases.
* `Onboarding` has new static builders for various types.

### 💡 Behavior changes

* `TutorialPageView` has one initializer for `Tutorial` and one for `GenericTutorial`.

### 💥 Breaking changes

* `Tutorial` is no longer generic.



## 6.1.1, 6.1.2

### ✨ New features

* `LocalizedTutorial` now supports custom bundles.



## 6.1

### 🗑 Deprecations

* `TutorialSlideView` has been renamed to `TutorialPageView`.
* `TutorialSlideViewStyle` has been renamed to `TutorialPageViewStyle`.



## 6.0

Tutti is renamed to OnboardingKit.
