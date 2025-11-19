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

You can create your own onboarding type by inheriting and customizing any of these classes.


### How to use an onboarding

The code below shows how we can use a standard ``Onboarding`` to present an onboarding sheet the very first time the app launches:

```swift
import OnboardingKit
import SwiftUI

struct ContentView: View {

    @State var isSheetPresented: Bool
    
    let onboarding = Onboarding(id: "welcome") 

    var body: some View {
        Text("Hello, world")
            .task(tryPresentOnboarding)
            .sheet(isPresented: $isSheetPresented) {
                Text("Onboarding...")
            }
    }
    
    func tryPresentOnboarding() {
        onboarding.tryPresent { 
            isSheetPresented = true
        }
    }
}
```

An onboarding only cares about its state and behavior, not how it's presented. You can present the content above in a full screen modal, popover from any view, by pushing a new view onto the navigation stack, etc.

An onboarding will honor its rules and state, so ``Onboarding/tryPresent(after:action:)`` will only trigger when it makes sense for it to show.



## Onboarding Flows

An onboarding flow is a set of pages that can be presented in any sequential way that makes sense for that onboarding. It can be a set of manually scrolling pages, a slideshow, a sequence of popovers, etc.

You can use ``OnboardingPageView`` to present a set of pages in a manually scrolling onboarding, and ``OnboardingSlideshow`` to present the same pages in an automatically scrolling slideshow.

You can wrap any flow control in an ``OnboardingFlowContainer`` to add toolbar and bottom buttons around the flow. You can use a ``OnboardingFlowState`` to control the flow state, instead of just using a plain integer binding.



## Onboarding Views

OnboardingKit has a set of standalone views, such as ``OnboardingIntroScreen`` and  ``OnboardingPrimaryButton``. The views can be used as standalone views, and don't require any integration with the rest of the library.
