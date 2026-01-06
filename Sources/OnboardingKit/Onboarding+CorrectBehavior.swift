//
//  Onboarding+CorrectBehavior.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2026 Daniel Saidi. All rights reserved.
//

import Foundation

extension Onboarding {

    /// This onboarding type is presented after a number of "incorrect behaviors",
    /// with the goal to help users behave as intended.
    ///
    /// An example could be a puzzle game for kids, where an onboarding could
    /// trigger the pieces animate to their correct positions.
    ///
    /// Call ``registerIncorrectBehavior(presentAfterSeconds:action:)``
    /// when a user doesn't behave as intended, to automatically present a help
    /// after a number of attempts. Call ``registerCorrectBehavior()``
    /// when the user then behaves as intended, to reset the attempt count. The
    /// onboarding can keep being used in case the user forgets.
    ///
    /// Unlike ``Onboarding``, this will reset itself each time it's presented.
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
