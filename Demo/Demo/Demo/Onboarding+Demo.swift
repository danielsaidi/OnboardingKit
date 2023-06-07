//
//  Onboarding+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import OnboardingKit

extension Onboarding {
    
    static let demoStandardHint = Onboarding(
        id: "standard.hint")
    static let demoCorrectBehaviorHint = CorrectBehaviorOnboarding(
        id: "correctbehavior.hint",
        requiredIncorrectAttempts: 3)
    static let demoDelayedHint = DelayedOnboarding(
        id: "delayed.hint",
        requiredPresentationAttempts: 3)
    
    static let demoStandardTutorial = Onboarding(
        id: "standard.tutorial")
    static let demoCorrectBehaviorTutorial = CorrectBehaviorOnboarding(
        id: "correctbehavior.tutorial",
        requiredIncorrectAttempts: 3)
    static let demoDelayedTutorial = DelayedOnboarding(
        id: "delayed.tutorial",
        requiredPresentationAttempts: 3)
    static let demoLocalizedTutorial = Onboarding(
        id: "localized.tutorial")
    
    static var demoOnboardings: [Onboarding] {
        [
            .demoStandardHint,
            .demoCorrectBehaviorHint,
            .demoDelayedHint,
            .demoStandardTutorial,
            .demoCorrectBehaviorTutorial,
            .demoDelayedTutorial,
            .demoLocalizedTutorial
        ]
    }
}
