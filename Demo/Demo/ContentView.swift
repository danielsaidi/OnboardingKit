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
    
    @State var isConditionalEnabled = false
    @State var isConditionalPresented = false
    @State var isCorrectBehaviorPresented = false
    @State var isDelayedPresented = false
    @State var isPopoverPresented = false
    @State var isSheetPresented = false
    @State var isPageViewPresented = false
    @State var isSlideshowPresented = false
    @State var isToolbarPopoverPresented = false
    
    @State var pageViewPageIndex = 0
    @State var slideshowPageIndex = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section("Onboardings") {
                    listButton(
                        .popover, 
                        presentPopover,
                        "Onboarding popover",
                        "This will only be presented once"
                    )
                    .demoPopover($isPopoverPresented)
                    
                    listButton(
                        .sheet,
                        presentSheet,
                        "Onboarding modal",
                        "This will only be presented once"
                    )
                    .sheet(isPresented: $isSheetPresented) {
                        Text("Use modal onboarding screens to show more complex onboardings, like page views or slideshows."
                        )
                        .padding()
                        .multilineTextAlignment(.center)
                    }
                    
                    VStack(spacing: 20) {
                        listButton(
                            .conditional,
                            presentConditional,
                            "Conditional onboarding",
                            "This will only be presented once, and only if the toggle below is enabled."
                        )
                        Toggle(isOn: $isConditionalEnabled) {}
                            .labelsHidden()
                            .padding(.leading, 5)
                    }
                    .demoPopover(
                        $isConditionalPresented,
                        text: "Conditional onboardings are great if a condition must be met before the onboarding is presented."
                    )

                    listButton(
                        .delayed,
                        presentDelayed,
                        "Delayed onboarding",
                        "This will only be presented once, and only after \(Onboarding.demoDelayed.requiredPresentationAttempts) taps."
                    )
                    .demoPopover(
                        $isDelayedPresented,
                        text: "Delayed onboardings are great to control the order of a list of onboardings."
                    )
                    
                    listButton(
                        .correctBehavior,
                        presentCorrectBehavior,
                        "Correct behavior onboarding",
                        "This will be presented every 3rd tap."
                    )
                    .demoPopover(
                        $isCorrectBehaviorPresented,
                        text: "Correct behavior onboardings are great to teach users how to behave, e.g. in games."
                    )
                }

                Section("Flows") {
                    listButton(
                        .popover,
                        presentLocalizedPageView,
                        "Present an onboarding page view",
                        "This onboarding flow lets you swipe through a set of pages."
                    )
                    .sheet(isPresented: $isPageViewPresented) {
                        DemoPageView(
                            onboarding: .demo,
                            index: $pageViewPageIndex
                        )
                    }

                    listButton(
                        .popover,
                        presentLocalizedSlideshow,
                        "Present an onboarding slideshow",
                        "This onboarding flow automatically slides through a set of pages."
                    )
                    .sheet(isPresented: $isSlideshowPresented) {
                        DemoSlideshow(
                            onboarding: .demo,
                            index: $pageViewPageIndex
                        )
                    }
                }
            }
            .navigationTitle("OnboardingKit")
            .onAppear(perform: presentToolbarPopover)
            .safeAreaInset(edge: .bottom) {
                VStack {
                    Divider()
                    Button("Reset onboarding state", action: reset)
                        .buttonStyle(.borderedProminent)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
            }
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

    func listButton(
        _ icon: Image,
        _ action: @escaping () -> Void,
        _ title: String,
        _ text: String
    ) -> some View {
        Button(action: action) {
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
        .buttonStyle(.plain)
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

@MainActor
private extension ContentView {
    
    var toolbarButton: some View {
        Button(action: presentToolbarPopover) {
            Image.popover.label("Show popover")
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

    func presentLocalizedPageView() {
        isPageViewPresented = true
    }

    func presentLocalizedSlideshow() {
        isSlideshowPresented = true
    }

    func presentPopover() {
        Onboarding.demoPopover.tryPresent {
            isPopoverPresented = true
        }
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
