#  Getting Started

This article describes how to get started with OnboardingKit.


## Onboarding

In OnboardingKit, an ``OnboardingKit/Onboarding`` determines the state and behavior of an onboarding experience.

OnboardingKit comes with different types of onboardings, e.g. ``OnboardingKit/Onboarding``, ``DelayedOnboarding``, ``ConditionalOnboarding`` etc. that can help you create a suitable experience for e.g. an initial onboarding, gamified systems etc.


## Hints

A ``Hint`` is a short onboarding message that is intended to be displayed briefly, e.g. in a toast, callout bubble etc.


## Tutorials

A ``Tutorial`` is a longer, page-based onboarding experience, e.g. a first-launch onboarding sheet.


## How to present a hint or a tutorial

The code below shows how to use a standard onboarding to present a hint or tutorial:

```swift
import OnboardingKit
import SwiftUI

struct ContentView: View {

    @State
    private var isOnboardingPresented: Bool 
    
    private let tutorial = LocalizedTutorial(id: "welcome")

    var body: some View {
        Text("Hello, world")
            .onAppear(tryPresentOnboarding)
            .sheet(isPresented: $isOnboardingPresented) {
                TutorialPageView(tutorial: tutorial)
            }
    }
    
    func tryPresentOnboarding() {
        let onboarding = Onboarding(id: "welcome")
        onboarding.tryPresent { 
            // Present the hint, for instance in a toast or a callout
            let hint = Hint(title: "Welcome!", text: "Welcome to this app.")
            // ...or, present a tutorial
            isOnboardingPresented = true
            // ...or do anything you want
        }
    }
}
```

As you can see in the code above, the onboarding holds the state and behavior, while the presentation block defines what should happen.


## Further reading

You can read more about onboardings, hints and tutorials in the <doc:Understanding-Onboardings>, <doc:Understanding-Hints> and <doc:Understanding-Tutorials> articles.
