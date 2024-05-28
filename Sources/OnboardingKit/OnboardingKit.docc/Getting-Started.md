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
                ... show your onboarding content here
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

OnboardingKit comes with a set of UI components that you can use to present more complex onboarding flows, like a multi-page one that is shown when the app is first launched.   

An ``OnboardingPageView`` can be used to render a set of pages in a horizontal page view that works on all platforms. You just have to pass in a set of pages of any type, then provide the view with a page view builder. 

An ``OnboardingSlideshow`` can be used to render a set of pages in a slideshow that automatically slides through the pages. You just have to pass in a set of pages of any type, then provide the view with a page view builder.

Both views can be styled by applying a style view modifier to the view hierarchy.


## Localization

You can use a ``LocalizedOnboarding`` to automatically generate pages from the localized strings in your project. This makes it easy to manage your onboarding with just text and assets, without writing any code.
