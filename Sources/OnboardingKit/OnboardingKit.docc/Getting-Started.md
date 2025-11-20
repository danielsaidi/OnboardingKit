#  Getting Started

This article describes how to get started with OnboardingKit.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}



## Overview

OnboardingKit has various ``Onboarding`` types that can be used to tailor an onboarding experience behavior, as well as various views.


## Onboardings

An ``Onboarding`` determines the behavior of an onboarding experience. There are different onboarding types for different behaviors: 

* ``Onboarding`` is presented right away, and only once.
* ``Onboarding``.``Onboarding/Conditional`` is presented when a certain condition returns `true`.
* ``Onboarding``.``Onboarding/CorrectBehavior`` is presented when a user is not behaving as intended.
* ``Onboarding``.``Onboarding/Delayed`` is presented after a certain number of presentation attempts.

You can also create a custom onboarding type by inheriting and customizing any of these classes and overriding its various functions.

To use an onboarding, just create a type based on the behavior you want, and call ``Onboarding/tryPresent(after:action:)`` to present it:

```swift
Onboarding(id: "welcome").tryPresent { 
    // Show a shet, modal, popover, or anything you want
}
```

The onboarding will honor it's behavior and only call the presentation block when it makes sense to the onboarding. For instance, a base onboarding is only presented once.



## Onboarding Flows

An onboarding flow is a collection of pages that can be presented in sequence. It can be a manually scrolling ``OnboardingPageView``, an automatically progressing ``OnboardingSlideshow``, a sequence of popovers, etc.

You can wrap any flow control in an ``OnboardingFlowContainer`` to add toolbar and bottom buttons around the flow. You can use a ``OnboardingFlowState`` to control the flow state, instead of just using a plain integer binding.



## Onboarding Views

OnboardingKit has a set of standalone views, such as ``OnboardingIntroScreen`` and  ``OnboardingPrimaryButton``. The views can be used as standalone views, and don't require any integration with the rest of the library.
