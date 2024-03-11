//
//  Onboarding+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation
import OnboardingKit

extension Onboarding {
    
    static var demoOnboardings: [Onboarding] = [
        demoListConditional(),
        demoListCorrectBehavior,
        demoListDelayed,
        demoListPopover,
        demoListSheet,
        demoToolbarPopover
    ]
    
    static func demoListConditional(
        _ condition: @escaping () -> Bool = { true }
    ) -> ConditionalOnboarding {
        .init(id: "demo.list.conditional", condition: condition)
    }
    
    static let demoListCorrectBehavior = CorrectBehaviorOnboarding(
        id: "demo.list.correctbehavior",
        requiredIncorrectAttempts: 3
    )
        
    static let demoListDelayed = DelayedOnboarding(
        id: "demo.list.delayed",
        requiredPresentationAttempts: 3
    )
    
    static let demoListPopover = Onboarding(id: "demo.list.popover")
    
    static let demoListSheet = Onboarding(id: "demo.list.sheet")
    
    static let demoToolbarPopover = Onboarding(id: "demo.toolbar.popover")
    
    static let demoLocalizedFlow = LocalizedOnboardingFlow(id: "demo-flow")
}
