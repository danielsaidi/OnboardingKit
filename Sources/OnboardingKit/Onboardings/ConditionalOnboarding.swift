//
//  ConditionalOnboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This onboarding type is only presented if bool condition
/// returns `true`.
///
/// An example could be a premium feature onboarding that is
/// only shown after signing up for a premium subscription.
///
/// Other than this, the onboarding behaves just like a base
/// ``Onboarding`` and is only presented once.
open class ConditionalOnboarding: Onboarding {
    
    /// Create a conditional onboarding.
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
