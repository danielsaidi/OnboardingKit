//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import OnboardingKit

struct ContentView: View {
    
    @State var isListConditionalEnabled = false
    @State var isListConditionalPresented = false
    @State var isListCorrectBehaviorPresented = false
    @State var isListDelayedPresented = false
    @State var isListPopoverPresented = false
    @State var isListSheetPresented = false
    @State var isLocalizedPageViewPresented = false
    @State var isLocalizedSlideshowPresented = false
    @State var isToolbarPopoverPresented = false
    
    @State var pageViewPageIndex = 0
    @State var slideshowPageIndex = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section("Onboardings") {
                    
                    // Standard onboardings
                    
                    Button(action: presentListPopover) {
                        LabeledContent {} label: {
                            Text("Present an onboarding popover")
                            Text("This will only be presented once")
                        }
                    }
                    .demoPopover($isListPopoverPresented)
                    
                    Button(action: presentListSheet) {
                        LabeledContent {} label: {
                            Text("Present an onboarding sheet")
                            Text("This will only be presented once")
                        }
                    }
                    
                    // Conditional onboarding
                    
                    HStack(spacing: 0) {
                        Button(action: presentListConditional) {
                            LabeledContent {} label: {
                                Text("Present a conditional onboarding")
                                Text("This will only be presented once, and only if the toggle is enabled.")
                            }
                        }
                        Toggle(isOn: $isListConditionalEnabled) {}
                            .labelsHidden()
                            .padding(.leading, 5)
                    }
                    .demoPopover(
                        $isListConditionalPresented,
                        text: "Conditional onboardings are great if you have a prerequisite that needs to be true before an onboarding is performed."
                    )
                    
                    // Delayed onboarding
                    
                    Button(action: presentListDelayed) {
                        LabeledContent {} label: {
                            Text("Present a delayed onboarding")
                            Text("This will be presented once, after \(Onboarding.demoDelayed.requiredPresentationAttempts) taps.")
                        }
                    }
                    .demoPopover(
                        $isListDelayedPresented,
                        text: "Delayed onboardings are great if you want to control the presentation order of a list of onboardings."
                    )
                    
                    // Correct Behavior onboarding
                    
                    button(
                        presentListCorrectBehavior,
                        "Present a correct behavior onboarding",
                        "You must tap this button \(Onboarding.demoCorrectBehavior.remainingPresentationAttempts) times more to show the onboarding."
                    )
                    .demoPopover(
                        $isListCorrectBehaviorPresented,
                        text: "Correct behavior onboardings are great if you want to make your users behave in a certain way, e.g. in games."
                    )
                }
                
                // Flows
                
                Section("Flows") {
                    button(
                        presentLocalizedFlowAsPageView,
                        "Present an onboarding page view",
                        "This onboarding flow lets you swipe through a set of pages."
                    )
                    button(
                        presentLocalizedFlowAsSlideshow,
                        "Present an onboarding slideshow",
                        "This onboarding flow automatically slides through a set of pages."
                    )
                }
            }
            .navigationTitle("OnboardingKit")
            .onAppear(perform: presentToolbarPopover)
            .safeAreaInset(edge: .bottom) {
                Button(action: reset) {
                    Text("Reset onboarding state")
                        .frame(minHeight: 50)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .background(Color.blue)
            }
            .sheet(isPresented: $isListSheetPresented) { listSheet }
            .sheet(isPresented: $isLocalizedPageViewPresented) { pageViewSheet }
            .sheet(isPresented: $isLocalizedSlideshowPresented) { slideshowSheet }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    toolbarButton
                        .demoPopover($isToolbarPopoverPresented)
                }
            }
        }
    }
}

private extension View {

    func button(
        _ action: @escaping () -> Void,
        _ title: String,
        _ text: String
    ) -> some View {
        Button(action: action) {
            LabeledContent {} label: {
                Text(title)
                Text(text)
            }
            .contentShape(Rectangle())
        }
    }

    func demoPopover(
        _ isPresented: Binding<Bool>,
        text: String = "Use popovers hints to inform the user about important parts of the UI."
    ) -> some View {
        self.popover(isPresented: isPresented) {
            Text(text)
                .padding()
                .padding(.vertical)
                #if os(iOS)
                .fixedSize(horizontal: false, vertical: true)
                .presentationCompactAdaptation(.none)
                #endif
        }
    }
}

private extension ContentView {
    
    var listSheet: some View {
        Text("Use modal sheets or covers to present launch onboarding flows.")
            .padding()
    }
    
    var pageViewSheet: some View {
        DemoPageView(
            onboarding: .demo,
            index: $pageViewPageIndex
        )
    }
    
    var slideshowSheet: some View {
        Text("Use modal sheets or covers to present launch onboarding flows.")
            .padding()
    }
}

@MainActor
private extension ContentView {
    
    var toolbarButton: some View {
        Button(action: presentToolbarPopover) {
            Image.popover.label("Show popover")
        }
    }

    func presentListConditional() {
        Onboarding.demoConditional { isListConditionalEnabled }
            .tryPresent { isListConditionalPresented = true }
    }
    
    func presentListCorrectBehavior() {
        Onboarding.demoCorrectBehavior
            .tryPresent { isListCorrectBehaviorPresented = true }
    }
    
    func presentListDelayed() {
        Onboarding.demoDelayed
            .tryPresent { isListDelayedPresented = true }
    }
    
    func presentListPopover() {
        Onboarding.demoPopover.tryPresent {
            isListPopoverPresented = true
        }
    }
    
    func presentListSheet() {
        Onboarding.demoSheet.tryPresent {
            isListSheetPresented = true
        }
    }
    
    func presentLocalizedFlowAsPageView() {
        isLocalizedPageViewPresented = true
    }
    
    func presentLocalizedFlowAsSlideshow() {
        isLocalizedSlideshowPresented = true
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
