//
//  Onboarding+Types.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2023-12-12.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Onboarding {
    
    /// Create a standard ``OnboardingKit/Onboarding``.
    static func standard(
        id: String,
        userId: UserId? = nil,
        defaults: UserDefaults = .standard
    ) -> Onboarding {
        .init(id: id, userId: userId, defaults: defaults)
    }
    
    /// Create a ``ConditionalOnboarding``.
    static func conditional(
        id: String,
        userId: UserId? = nil,
        defaults: UserDefaults = .standard,
        condition: @escaping ConditionalOnboarding.Condition
    ) -> ConditionalOnboarding {
        .init(
            id: id,
            userId: userId,
            defaults: defaults,
            condition: condition
        )
    }
    
    /// Create a ``CorrectBehaviorOnboarding``.
    static func correctBehavior(
        id: String,
        userId: UserId? = nil,
        defaults: UserDefaults = .standard,
        requiredIncorrectAttempts: Int
    ) -> CorrectBehaviorOnboarding {
        .init(
            id: id,
            userId: userId,
            defaults: defaults,
            requiredIncorrectAttempts: requiredIncorrectAttempts
        )
    }
    
    /// Create a ``DelayedOnboarding``.
    static func delayed(
        id: String,
        userId: UserId? = nil,
        defaults: UserDefaults = .standard,
        requiredPresentationAttempts: Int
    ) -> DelayedOnboarding {
        .init(
            id: id,
            userId: userId,
            defaults: defaults,
            requiredPresentationAttempts: requiredPresentationAttempts
        )
    }
}
