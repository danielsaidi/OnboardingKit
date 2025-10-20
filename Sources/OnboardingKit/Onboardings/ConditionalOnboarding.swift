//
//  ConditionalOnboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This onboarding type is only presented if bool condition returns `true`.
///
/// One example could be a premium feature onboarding that is only shown after
/// signing up for a premium subscription.
///
/// Other than this, this onboarding type behaves like the base ``Onboarding``,
/// and is only presented once.
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
