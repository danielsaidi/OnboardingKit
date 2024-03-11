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

In OnboardingKit, an ``Onboarding`` determines the state and behavior of an onboarding experience. You can use various onboarding types to get different behaviors, like these build-in ones: 

* ``Onboarding`` is presented right away, and only once.
* ``ConditionalOnboarding`` is presented when a certain condition returns `true`.
* ``CorrectBehaviorOnboarding`` is presented when a user is not behaving as intended.
* ``DelayedOnboarding`` is presented after a certain number of presentation attempts.

You can create your own onboarding types by inheriting and customizing any of these classes.



## How to trigger an onboarding

The code below shows how to use a standard ``Onboarding`` to present an onboarding sheet the first time an app launches:

```swift
import OnboardingKit
import SwiftUI

struct ContentView: View {

    @State
    private var isOnboardingPresented: Bool
    
    private let onboarding = Onboarding(id: "welcome") 

    var body: some View {
        Text("Hello, world")
            .task(tryPresentOnboarding)
            .sheet(isPresented: $isOnboardingPresented) {
                ...
            }
    }
    
    func tryPresentOnboarding() {
        onboarding.tryPresent { 
            isOnboardingPresented = true
        }
    }
}
```

The onboarding only cares about state and behavior, not how it's presented. You can present the content above in a full screen modal, a popover from any view, or by pushing a new view onto the navigation stack.

The onboarding will honor its own rules and state, so `tryPresent` will only trigger when it makes sense for the onboarding to show.



## Views

The ``OnboardingPageView`` can be used to render a collection of pages in a horizontally sliding onboarding flow. It behaves like a regular page view styled tab view, but unlike that component this one works on all platforms.


## Localization

You can use a ``LocalizedOnboardingFlow`` to automatically generate onboarding pages from the localized strings in your project. This makes it easy to manage your onboarding flows with just text and assets, without writing more code.
