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


## Onboarding Types

An ``Onboarding`` determines the state and behavior of an onboarding experience. 

You can use different types for different behaviors, like these built-in ones: 

* ``Onboarding`` is presented right away, and only once.
* ``ConditionalOnboarding`` is presented when a certain condition returns `true`.
* ``CorrectBehaviorOnboarding`` is presented when a user is not behaving as intended.
* ``DelayedOnboarding`` is presented after a certain number of presentation attempts.

You can create your own onboarding types by inheriting and customizing any of these classes.



## How to trigger an onboarding

The code below shows how we can use a standard ``Onboarding`` to present an onboarding sheet the very first time the app launches:

```swift
import OnboardingKit
import SwiftUI

struct ContentView: View {

    @State var isOnboardingPresented: Bool
    
    let onboarding = Onboarding(id: "welcome") 

    var body: some View {
        Text("Hello, world")
            .task(tryPresentOnboarding)
            .sheet(isPresented: $isOnboardingPresented) {
                Text("Onboarding...")
            }
    }
    
    func tryPresentOnboarding() {
        onboarding.tryPresent { 
            isOnboardingPresented = true
        }
    }
}
```

An onboarding only cares about its state and behavior, not how it's presented. You can present the content above in a full screen modal, popover from any view, by pushing a new view onto the navigation stack, etc.

An onboarding will honor its rules and state, so ``Onboarding/tryPresent(after:action:)`` will only trigger when it makes sense for it to show.



## Views

OnboardingKit has a couple of views that can be used to present complex onboarding flows, as well as many ways to handle page state.

An ``OnboardingPageView`` can be used to render a set of pages in a horizontal page view that works on all platforms. 

An ``OnboardingSlideshow`` can be used to render a set of pages in a slideshow that automatically slides through the pages. 

You can use an ``OnboardingPageState`` instance to manage page state for both views, then provide them with a page view builder that builds a page view for each page. Both views can be styled by applying a style view modifier to the view hierarchy.
