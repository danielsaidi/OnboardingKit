//
//  CorrectBehaviorOnboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This onboarding type is presented after a number of "incorrect behaviors", with
/// the goal to help users behave as intended.
///
/// An example could be a puzzle game for kids, where the onboarding could then
/// trigger the pieces animate to their correct position to show what to do.
///
/// Call ``registerIncorrectBehavior()`` when the user doesn't behave
/// as you intended, to automatically present an onboarding after a certain number
/// of attempts. Call ``registerCorrectBehavior()`` when the user behaves
/// as intended, to reset the attempt count.
///
/// Unlike ``DelayedOnboarding``, this onboarding will reset itself each time
/// it's presented.
open class CorrectBehaviorOnboarding: DelayedOnboarding {

    /// Create a correct behavior onboarding.
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

    /// The number of incorrect attempts before this onboarding should be presented.
    open var requiredIncorrectAttempts: Int {
        super.requiredPresentationAttempts
    }

    /// Call this function when the user behaves correctly, to reset the state.
    open func registerCorrectBehavior() {
        reset()
    }

    /// Call this function when the user behaves incorrectly, to increase the counter.
    @MainActor
    open func registerIncorrectBehavior(
        presentAfterSeconds seconds: TimeInterval = 0,
        action: @escaping () -> Void
    ) {
        tryPresent(after: seconds, action: action)
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
