//
//  ConditionalOnboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This onboarding type takes a boolean conditional, that must
 return `true` for ``shouldBePresented`` to become true.

 An example could be an onboarding that should only be shown
 when a certain condition kicks in.
 
 Other than that, this onboarding behaves just like the base
 ``Onboarding`` and is only presented once.
 */
open class ConditionalOnboarding: Onboarding {
    
    /// Create a conditional onboarding instance.
    public init(
        id: String,
        store: UserDefaults = .standard,
        condition: @escaping Condition
    ) {
        self.condition = condition
        super.init(id: id, store: store)
    }
    
    public typealias Condition = () -> Bool
    
    public let condition: Condition
    
    /// Whether or not the onboarding should be presented.
    open override var shouldBePresented: Bool {
        condition() && super.shouldBePresented
    }
}
