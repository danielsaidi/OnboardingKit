//
//  Onboarding+CorrectBehavior.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2026 Daniel Saidi. All rights reserved.
//

import Foundation

extension Onboarding {

    /// This onboarding type is presented after the user has
    /// performed a a number of "incorrect behaviors".
    ///
    /// This can be used to help the user behave as intended,
    /// for instance by showing a child how a game is played.
    ///
    /// Call ``registerIncorrectBehavior(presentAfterSeconds:action:)``
    /// when the user behaves incorrectly. This will present
    /// the onboarding after a certain number of attempts to
    /// show the user how to behave.
    ///
    /// Call ``registerCorrectBehavior()`` when the user has
    /// behaved as intended, to reset the attempt count. The
    /// onboarding will keep listening to incorrect attempts,
    /// to present the onboarding again, if needed.
    ///
    /// Unlike a standard ``Onboarding`` this type will keep
    /// presenting itself if users keep behaving incorrectly.
    open class CorrectBehavior: Delayed {

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

        /// The number of required incorrect attempts before
        /// the onboarding is presented.
        open var requiredIncorrectAttempts: Int {
            super.requiredPresentationAttempts
        }

        /// Register a correct user behavior.
        ///
        /// This will reset the behavior counter and restart.
        open func registerCorrectBehavior() {
            reset()
        }

        /// Register an incorrect user behavior.
        ///
        /// This will increment the behavior counter and use
        /// the `action` to present an onboarding, if needed.
        @MainActor
        open func registerIncorrectBehavior(
            presentAfterSeconds seconds: TimeInterval = 0,
            action: @escaping () -> Void
        ) {
            tryPresent(after: seconds, action: action)
        }

        /// Present the onboarding with the provided `action`.
        open override func present(
            after seconds: TimeInterval = 0,
            action: @escaping () -> Void
        ) {
            super.present(after: seconds, action: action)
            reset()
        }
    }
}

public extension Onboarding {

    static func correctBehavior(
        id: String,
        store: UserDefaults = .standard,
        requiredIncorrectAttempts attempts: Int
    ) -> CorrectBehavior {
        .init(id: id, store: store, requiredIncorrectAttempts: attempts)
    }
}
