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

An onboarding flow is a collection of pages that can be presented in sequence. You can wrap any flow control in an ``OnboardingFlowContainer`` to add toolbar and bottom buttons around it, and use an ``OnboardingFlowState`` to control the flow state.



## Views

OnboardingKit has flow views like ``OnboardingPageView`` and ``OnboardingSlideshow``, screen template views like ``OnboardingIntroScreen``, and smaller components like ``OnboardingPrimaryButton``, ``OnboardingVerticalProgressList``, etc.

@Row {
    @Column {
        ![A PageView screenshot](PageView)
    }
    @Column {
        ![A Slideshow screenshot](Slideshow)
    }
    @Column {
        ![An IntroScreen screenshot](IntroScreen)
    }
}

You can use the smaller components in the larger ones, and style each component to great extent. For instance an ``OnboardingPageViewStyle`` can be applied with ``SwiftUICore/View/onboardingPageViewStyle(_:)`` to style an ``OnboardingPageView``.


## Demo Application

Check out the demo application for examples on how these views can be used.
