//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import OnboardingKit

struct ContentView: View {

    @State var isAppWelcomeScreenPresented = false
    @State var isConditionalEnabled = false
    @State var isConditionalPresented = false
    @State var isCorrectBehaviorPresented = false
    @State var isDelayedPresented = false
    @State var isPopoverPresented = false
    @State var isSheetPresented = false
    @State var isToolbarPopoverPresented = false

    @State var pageViewPageIndex = 0
    @State var slideshowPageIndex = 0

    var body: some View {
        NavigationStack {
            List {
                Section("Welcome Screen") {
                    appWelcomeScreenButton
                }
                Section("Onboardings") {
                    popoverButton
                    sheetButton
                    conditionalButton
                    delayedButton
                    behaviorButton
                }
                Section("Flows") {
                    pageViewLink
                    slideshowLink
                }
            }
            .task { presentAppWelcomeScreen() }
            .tint(.primary)
            .navigationTitle("OnboardingKit")
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 0) {
                    Divider()
                    OnboardingPrimaryButton(
                        "Reset onboarding state",
                        action: reset
                    )
                    .padding()
                }
                .background(.thinMaterial)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    toolbarButton
                }
            }
        }
        .sheet(isPresented: $isAppWelcomeScreenPresented) {
            WelcomeScreen()
        }
    }
}

// MARK: - Buttons

private extension ContentView {

    var appWelcomeScreenButton: some View {
        Button(action: presentAppWelcomeScreen) {
            listLabel(
                .sheet,
                "Welcome Screen",
                "This will only be presented once."
            )
        }
    }

    var behaviorButton: some View {
        Button(action: presentCorrectBehavior) {
            listLabel(
                .correctBehavior,
                "Correct behavior popover",
                "This will be presented every 3rd tap."
            )
        }
        .onboardingPopover(
            "Correct behavior onboardings are great to teach users how to behave, e.g. in games.",
            isPresented: $isCorrectBehaviorPresented
        )
    }

    var conditionalButton: some View {
        Button(action: presentConditional) {
            HStack(spacing: 20) {
                listLabel(
                    .conditional,
                    "Conditional onboarding",
                    "This will only be presented once, if the toggle is enabled."
                )
                Toggle(isOn: $isConditionalEnabled) {}
                    .labelsHidden()
            }
        }
        .onboardingPopover(
            "Conditional onboardings are great if a condition must be met before the onboarding is presented.",
            isPresented: $isConditionalPresented
        )
    }

    var delayedButton: some View {
        Button(action: presentDelayed) {
            listLabel(
                .delayed,
                "Delayed popover",
                "This will only be presented once, and only after \(Onboarding.demoDelayed.requiredPresentationAttempts) taps."
            )
        }
        .onboardingPopover(
            "Use popovers hints to inform the user about important parts of the UI.",
            isPresented: $isDelayedPresented
        )
    }

    var pageViewLink: some View {
        NavigationLink {
            DemoOnboardingScreen(type: .pageView)
        } label: {
            listLabel(
                .pageView,
                "Page View",
                "Step through a number of pages."
            )
        }
    }

    var popoverButton: some View {
        Button(action: presentPopover) {
            listLabel(
                .popover,
                "Onboarding popover",
                "This will only be presented once"
            )
        }
        .onboardingPopover(
            "Use popovers hints to inform the user about important parts of the UI.",
            isPresented: $isPopoverPresented
        )
    }

    var sheetButton: some View {
        Button(action: presentSheet) {
            listLabel(
                .sheet,
                "Onboarding sheet",
                "This will only be presented once"
            )
        }
        .sheet(isPresented: $isSheetPresented) { sheet }
    }

    var sheet: some View {
        Text("Use modal onboarding screens to show more complex onboardings, like page views or slideshows."
        )
        .padding()
        .multilineTextAlignment(.center)
    }

    var slideshowLink: some View {
        NavigationLink {
            DemoOnboardingScreen(type: .slideshow)
        } label: {
            listLabel(
                .slideshow,
                "Slideshow",
                "Slide through a number of pages."
            )
        }
    }

    var toolbarButton: some View {
        Button(action: presentToolbarPopover) {
            Image.popover.label("Show popover")
        }
        .onboardingPopover(
            "Use popovers hints to inform the user about important parts of the UI.",
            isPresented: $isToolbarPopoverPresented
        )
    }
}

// MARK: - Views

private extension View {

    func listButton<Content: View>(
        _ action: @escaping () -> Void,
        _ content: @escaping () -> Content
    ) -> some View {
        Button(action: action) {
            content()
        }
        .buttonStyle(.plain)
    }

    func listLabel(
        _ icon: Image,
        _ title: String,
        _ text: String
    ) -> some View {
        Label(
            title: {
                LabeledContent {} label: {
                    Text(title)
                    Text(text)
                }
            },
            icon: {
                icon
            }
        )
        .contentShape(Rectangle())
    }
}

// MARK: - Functions

@MainActor
private extension ContentView {

    func presentAppWelcomeScreen() {
        Onboarding.demoWelcomeScreen.tryPresent {
            isAppWelcomeScreenPresented = true
        }
    }

    func presentConditional() {
        Onboarding.demoConditional { isConditionalEnabled }
            .tryPresent { isConditionalPresented = true }
    }
    
    func presentCorrectBehavior() {
        Onboarding.demoCorrectBehavior
            .tryPresent { isCorrectBehaviorPresented = true }
    }
    
    func presentDelayed() {
        Onboarding.demoDelayed
            .tryPresent { isDelayedPresented = true }
    }

    func presentPopover() {
        Onboarding.demoPopover
            .tryPresent { isPopoverPresented = true }
    }
    
    func presentSheet() {
        Onboarding.demoSheet.tryPresent {
            isSheetPresented = true
        }
    }
    
    func presentToolbarPopover() {
        Onboarding.demoToolbarPopover.tryPresent {
            isToolbarPopoverPresented = true
        }
    }

    func reset() {
        Onboarding.demoOnboardings.forEach { $0.reset() }
    }
}

#Preview {
    
    ContentView()
}
