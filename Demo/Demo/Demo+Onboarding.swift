//
//  Onboarding+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import OnboardingKit

extension Onboarding {

    // This lets us reset all onboardings with a single call.
    static var demoOnboardings: [Onboarding] = [
        demoConditional(),
        demoCorrectBehavior,
        demoDelayed,
        demoPopover,
        demoSheet,
        demoToolbarPopover,
        demoWelcomeScreen
    ]
    
    static func demoConditional(
        _ condition: @escaping () -> Bool = { true }
    ) -> Onboarding {
        Onboarding.Conditional(id: "onboarding.conditional", condition: condition)
    }
    
    static let demoCorrectBehavior = Onboarding.CorrectBehavior(
        id: "onboarding.correctbehavior",
        requiredIncorrectAttempts: 3
    )
        
    static let demoDelayed = Onboarding.Delayed(
        id: "onboarding.delayed",
        requiredPresentationAttempts: 3
    )
    
    static let demoPopover = Onboarding(id: "onboarding.popover")
    static let demoSheet = Onboarding(id: "onboarding.sheet")
    static let demoToolbarPopover = Onboarding(id: "onboarding.toolbarpopover")
    static let demoWelcomeScreen = Onboarding(id: "demo.welcomeScreen")
}
