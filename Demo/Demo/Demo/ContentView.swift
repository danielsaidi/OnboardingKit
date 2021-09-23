//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import Tutti

struct ContentView: View {
    
    @State private var isHintActive = false
    @State private var isTutorialActive = false
    
    @State private var currentAlert = Alert(title: Text(""), message: Text(""))
    @State private var currentTutorial = DemoTutorialSheet(tutorial: .demoStandard)
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Hints")) {
                    button(.hint, "Show a standard hint", "This will only be presented once.", showStandardHint)
                    button(.delayed, "Show a delayed hint", "This requires 3 attempts and will only be presented once.", showDelayedHint)
                    button(.incorrectBehavior, "Behave incorrectly", "After 3 times, a hint will be presented.", behaveIncorrectlyForHint)
                    button(.correctBehavior, "Behave correctly", "This resets previous incorrect behaviors.", behaveCorrectlyForHint)
                }
                Section(header: Text("Tutorials")) {
                    button(.tutorial, "Show a standard tutorial", "This will only be presented once.", showStandardTutorial)
                    button(.delayed, "Show a delayed tutorial", "This requires 3 attempts and will only be presented once.", showDelayedTutorial)
                    button(.incorrectBehavior, "Behave incorrectly", "After 3 times, a tutorial will be presented.", behaveIncorrectlyForTutorial)
                    button(.correctBehavior, "Behave correctly", "This resets previous incorrect behaviors.", behaveCorrectlyForTutorial)
                }
                Section(header: Text("Actions")) {
                    button(.reset, "Reset all onboarding", "This will put all onboardings in their initial state.", resetOnboardings)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Tutti Demo")
        }
        .alert(isPresented: $isHintActive) { currentAlert }
        .sheet(isPresented: $isTutorialActive) { currentTutorial }
    }
}

private extension ContentView {
    
    func button(_ icon: Image, _ title: String, _ text: String, _ action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 20) {
                icon.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title).font(.body)
                    if text.count > 0 {
                        Text(text).font(.footnote)
                    }
                }
            }.background(Color.white.opacity(0.0001))
        }
        .buttonStyle(.plain)
        .padding(.vertical, 5)
    }
}

private extension ContentView {
    
    func behaveCorrectlyForHint() {
        let onboarding = Onboarding.demoCorrectBehaviorHint
        onboarding.registerCorrectBehavior()
    }
    
    func behaveCorrectlyForTutorial() {
        let onboarding = Onboarding.demoCorrectBehaviorTutorial
        onboarding.registerCorrectBehavior()
    }
    
    func behaveIncorrectlyForHint() {
        let onboarding = Onboarding.demoCorrectBehaviorHint
        onboarding.registerIncorrectBehavior()
        tryPresentHint(.demoCorrectBehavior, for: onboarding)
    }
    
    func behaveIncorrectlyForTutorial() {
        let onboarding = Onboarding.demoCorrectBehaviorTutorial
        onboarding.registerIncorrectBehavior()
        tryPresentTutorial(.demoCorrectBehavior, for: onboarding)
    }
    
    func resetOnboardings() {
        Onboarding.demoOnboardings.forEach { $0.reset() }
    }
    
    func showDelayedHint() {
        let onboarding = Onboarding.demoDelayedHint
        tryPresentHint(.demoDelayed, for: onboarding)
    }
    
    func showDelayedTutorial() {
        let onboarding = Onboarding.demoDelayedTutorial
        tryPresentTutorial(.demoDelayed, for: onboarding)
    }
    
    func showStandardHint() {
        let onboarding = Onboarding.demoStandardHint
        tryPresentHint(.demoStandard, for: onboarding)
    }
    
    func showStandardTutorial() {
        let onboarding = Onboarding.demoStandardTutorial
        tryPresentTutorial(.demoStandard, for: onboarding)
    }
    
    func tryPresentHint(_ hint: Hint, for onboarding: Onboarding) {
        guard onboarding.shouldBePresented else { return }
        currentAlert = Alert(title: Text(hint.title), message: Text(hint.text))
        isHintActive = true
        onboarding.registerPresentation()
    }
    
    func tryPresentTutorial(_ tutorial: Tutorial, for onboarding: Onboarding) {
        guard onboarding.shouldBePresented else { return }
        currentTutorial = DemoTutorialSheet(tutorial: tutorial)
        isTutorialActive = true
        onboarding.registerPresentation()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
