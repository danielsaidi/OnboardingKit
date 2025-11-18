# Release notes

This project honors semantic versioning, with the following strategy:

* Deprecations can happen at any time.
* Deprecations are removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if the alternative is worse.

Beta version tags are removed after the next minor or major version. 

These release notes only cover the current major version.



## 9.0

This version makes the SDK target iOS 17 and aligned versions.

### ✨ New features

* `OnboardingIntroScreen` is a new template view. 

### 💡 Changes

* `OnboardingPageState` now implements `@Observable`.

### 🐛 Bug Fixes

* This version fixes a bug in `CorrectOnboardingBehavior`.

### 💥 Breaking Changes

* This version makes the SDK target iOS 17 and aligned versions.
* The various onboarding types are now nested under `Onboarding`.
* The `Onboarding` type builder functions have been removed.



## 8.4

This version makes the SDK use Swift 6.1.

Since this is the only change, it's made with a minor version bump.



## 8.3.1

### 🐛 Bug Fixes

* This version fixes multi-platform builds.



## 8.3

### ✨ New features

* `OnboardingPageInfo` `currentPageIndex` is now mutable.
* `OnboardingPageManager` is a new page manager protocol.
* `OnboardingPageState` is a new observable page state class.
* `OnboardingPageView` & `OnboardingSlideshow` now supports edge taps on all platforms.
* `OnboardingPageView` & `OnboardingSlideshow` now supports arrow keys on macOS & tvOS.
* `OnboardingPrimaryButton` is a new button view that can be used in an onboarding flow.
* `OnboardingScreen` is a new container view that can be used to wrap any onboarding flow.  
* `OnboardingScreenCenteredContent` is a new container view that can be used to center a page view.
* `View` has new `onboardingPopover` modifiers that makes it easy to present a popover from any view.  

### 💡 Adjustments

* `OnboardingSlideshow` now takes a configuration as a view modifier.

### 🐛 Bug Fixes

* `OnboardingPageView` & `OnboardingSlideshow` no longer block interactions.

### 🗑️ Deprecated

* `LocalizedOnboarding` has been deprecated.
* `OnboardingSlideshow` no longer takes a background view builder.
* `OnboardingSlideshowConfiguration` no longer has an `isAnimated` property.



## 8.2

### ✨ New features

* `OnboardingSlideshow` is now available to all platforms. 



## 8.1

This version updates the package for Swift 6.



## 8.0

This version adds support for strict concurrency and a new `OnboardingSlideshow` component.

To simplify the `OnboardingPageView` and `OnboardingSlideshow` view builder setup, these functions have been refactored to only use `OnboardingPageInfo` as parameter.

### ✨ New features

* `OnboardingSlideshow` is a new view that automatically slides through a set of pages. 
