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

In OnboardingKit, an ``Onboarding`` determines the state and behavior of an onboarding experience. You can use various onboarding types to get different behaviors.

OnboardingKit comes with a collection of built-in onboarding types, that can be used for different purposes. 

* ``Onboarding`` is presented right away, and only once.
* ``ConditionalOnboarding`` is presented when a certain condition returns `true`.
* ``CorrectBehaviorOnboarding`` is presented when a user is not behaving as intended.
* ``DelayedOnboarding`` is presented after a certain number of presentation attempts.

You can create your own onboarding types by inheriting and customizing any of these classes.



## How to trigger an onboarding

The code below shows how to use a standard ``Onboarding`` to present a first launch onboarding sheet:

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

The onboarding will honor its own rules and state, so `tryPresent` will only trigger when it makes sense for the onboarding to show.



## Views

An ``OnboardingPageView`` can be used to render a collection of pages in an onboarding flow. It behaves like a regular `TabView` with page style, but unlike that native component it works on all platforms.


## Localization

You can use a ``LocalizedOnboardingFlow`` to automatically generate onboarding pages from the localized strings in your project.
