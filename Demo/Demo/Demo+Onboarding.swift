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
    
    static var demoOnboardings: [Onboarding] = [
        demoConditional(),
        demoCorrectBehavior,
        demoDelayed,
        demoPopover,
        demoSheet,
        demoToolbarPopover
    ]
    
    static func demoConditional(
        _ condition: @escaping () -> Bool = { true }
    ) -> Onboarding {
        Onboarding.Conditional(id: "demo.list.conditional", condition: condition)
    }
    
    static let demoCorrectBehavior = Onboarding.CorrectBehavior(
        id: "demo.list.correctbehavior",
        requiredIncorrectAttempts: 3
    )
        
    static let demoDelayed = Onboarding.Delayed(
        id: "demo.list.delayed",
        requiredPresentationAttempts: 3
    )
    
    static let demoPopover = Onboarding(id: "demo.list.popover")
    
    static let demoSheet = Onboarding(id: "demo.list.sheet")

    static let demoToolbarPopover = Onboarding(id: "demo.toolbar.popover")
}
