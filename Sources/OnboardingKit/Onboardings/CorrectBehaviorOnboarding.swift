//
//  CorrectBehaviorOnboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This onboarding type can help users behave as intended, for
 instance to show a guide when the user fails multiple times.
 
 An example could be a puzzle game, where pieces can animate
 to their position after being incorrectly placed many times.
 
 Just call ``tryPresent(delay:action:)`` when a user behaves
 incorrectly or not as intended. The onboarding will perform
 the presentation after the defined number of attempts. Just
 call ``registerCorrectBehavior()`` when the user behaves as
 intended, to reset the onboarding state.
 
 Unlike ``DelayedOnboarding``, which the onboarding inherits,
 this onboarding type resets itself each time it's presented.
 */
open class CorrectBehaviorOnboarding: DelayedOnboarding {
    
    /// Create a correct behavior onboarding instance.
    public init(
        id: String,
        store: UserDefaults = .standard,
        requiredIncorrectAttempts: Int
    ) {
        super.init(
            id: id,
            store: store,
            requiredPresentationAttempts: requiredIncorrectAttempts
        )
    }
    
    /// The number of incorrect attempts allowed before this
    /// onboarding should be presented.
    public var requiredIncorrectAttempts: Int {
        super.requiredPresentationAttempts
    }
    
    /// Call this function when the user behaves as intended,
    /// to reset the onboarding state.
    public func registerCorrectBehavior() {
        reset()
    }
    
    /// Present the onboarding with the provided action then
    /// reset the onboarding state.
    open override func present(
        after seconds: TimeInterval = 0,
        action: @escaping () -> Void
    ) {
        super.present(after: seconds, action: action)
        reset()
    }
}
