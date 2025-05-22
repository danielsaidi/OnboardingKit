# Release Notes

OnboardingKit tried to honors semantic versioning.

Breaking changes can still occur in minor updates, if there's a strong reason for it.



## 8.3

### ✨ New features

* `OnboardingPageView` & `OnboardingSlideshow` now supports edge taps on all platforms.
* `OnboardingPageView` & `OnboardingSlideshow` now supports arrow keys on macOS & tvOS.
* `OnboardingPrimaryButton` is a new button view that can be used in an onboarding flow.
* `OnboardingScreen` is a new container view that can be used to wrap any onboarding flow.  
* `OnboardingScreenCenteredContent` is a new container view that can be used to center a page view.  

### 🐛 Bug Fixes

* `OnboardingPageView` & `OnboardingSlideshow` no longer blocks user interaction.



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
