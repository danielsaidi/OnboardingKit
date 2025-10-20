//
//  Onboarding+Types.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2023-12-12.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This extension defines shorthands to built-in onboarding types.
public extension Onboarding {
    
    /// Create a standard ``Onboarding``.
    static func standard(
        id: String,
        store: UserDefaults = .standard
    ) -> Onboarding {
        .init(id: id, store: store)
    }
    
    /// Create a ``ConditionalOnboarding``.
    static func conditional(
        id: String,
        store: UserDefaults = .standard,
        condition: @escaping ConditionalOnboarding.Condition
    ) -> ConditionalOnboarding {
        .init(
            id: id,
            store: store,
            condition: condition
        )
    }
    
    /// Create a ``CorrectBehaviorOnboarding``.
    static func correctBehavior(
        id: String,
        store: UserDefaults = .standard,
        requiredIncorrectAttempts attempts: Int
    ) -> CorrectBehaviorOnboarding {
        .init(
            id: id,
            store: store,
            requiredIncorrectAttempts: attempts
        )
    }
    
    /// Create a ``DelayedOnboarding``.
    static func delayed(
        id: String,
        store: UserDefaults = .standard,
        requiredPresentationAttempts attempts: Int
    ) -> DelayedOnboarding {
        .init(
            id: id,
            store: store,
            requiredPresentationAttempts: attempts
        )
    }
}
