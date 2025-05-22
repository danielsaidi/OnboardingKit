# Release Notes

OnboardingKit tried to honors semantic versioning.

Breaking changes can still occur in minor updates, if there's a strong reason for it.



## 8.3

### ✨ New features

* The multi-platform `PageView` now supports arrow navigation and edge taps.

### 🐛 Bug Fixes

* The multi-platform `PageView` no longer blocks user interaction.



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
