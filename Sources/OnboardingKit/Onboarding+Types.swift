//
//  Onboarding+Types.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2023-12-12.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This extension defines shorthands to built-in onboarding
/// types, which is more convenient.
public extension Onboarding {
    
    /// Create a standard ``Onboarding``.
    static func standard(
        id: String,
        defaults: UserDefaults = .standard
    ) -> Onboarding {
        .init(id: id, defaults: defaults)
    }
    
    /// Create a ``ConditionalOnboarding``.
    static func conditional(
        id: String,
        defaults: UserDefaults = .standard,
        condition: @escaping ConditionalOnboarding.Condition
    ) -> ConditionalOnboarding {
        .init(
            id: id,
            defaults: defaults,
            condition: condition
        )
    }
    
    /// Create a ``CorrectBehaviorOnboarding``.
    static func correctBehavior(
        id: String,
        defaults: UserDefaults = .standard,
        requiredIncorrectAttempts attempts: Int
    ) -> CorrectBehaviorOnboarding {
        .init(
            id: id,
            defaults: defaults,
            requiredIncorrectAttempts: attempts
        )
    }
    
    /// Create a ``DelayedOnboarding``.
    static func delayed(
        id: String,
        defaults: UserDefaults = .standard,
        requiredPresentationAttempts attempts: Int
    ) -> DelayedOnboarding {
        .init(
            id: id,
            defaults: defaults,
            requiredPresentationAttempts: attempts
        )
    }
}
