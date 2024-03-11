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
                            Text("This will be presented once, after \(Onboarding.demoListDelayed.requiredPresentationAttempts) taps.")
                        }
                    }
                    .demoPopover(
                        $isListDelayedPresented,
                        text: "Delayed onboardings are great if you want to control the presentation order of a list of onboardings."
                    )
                    
                    // Correct Behavior onboarding
                    
                    Button(action: presentListCorrectBehavior) {
                        LabeledContent {} label: {
                            Text("Present a correct behavior onboarding")
                            Text("This will be presented every time you tap this button  \(Onboarding.demoListCorrectBehavior.requiredPresentationAttempts) times.")
                        }
                    }
                    .demoPopover(
                        $isListCorrectBehaviorPresented,
                        text: "Correct behavior onboardings are great if you want to make your users behave in a certain way, e.g. in games."
                    )
                }
                
                // Flows
                
                Section("Flows") {
                    Button(action: presentLocalizedFlowAsPageView) {
                        LabeledContent {} label: {
                            Text("Present a localized page view")
                            Text("Swipe through a localized onboarding flow.")
                        }
                    }
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
            flow: Onboarding.demoLocalizedFlow,
            index: $pageViewPageIndex
        )
    }
    
    var slideshowSheet: some View {
        Text("Use modal sheets or covers to present launch onboarding flows.")
            .padding()
    }
    
    var toolbarButton: some View {
        Button(action: presentToolbarPopover) {
            Image.popover.label("Show popover")
        }
    }
}

private extension ContentView {
    
    func presentListConditional() {
        Onboarding.demoListConditional { isListConditionalEnabled }
            .tryPresent { isListConditionalPresented = true }
    }
    
    func presentListCorrectBehavior() {
        Onboarding.demoListCorrectBehavior
            .tryPresent { isListCorrectBehaviorPresented = true }
    }
    
    func presentListDelayed() {
        Onboarding.demoListDelayed
            .tryPresent { isListDelayedPresented = true }
    }
    
    func presentListPopover() {
        Onboarding.demoListPopover.tryPresent {
            isListPopoverPresented = true
        }
    }
    
    func presentListSheet() {
        Onboarding.demoListSheet.tryPresent {
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
