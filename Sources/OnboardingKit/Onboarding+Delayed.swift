//
//  Onboarding+Delayed.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2026 Daniel Saidi. All rights reserved.
//

import Foundation

extension Onboarding {

    /// This onboarding type is delayed, and only triggers a
    /// presentation after a few attempts.
    ///
    /// Delayed onboardings are convenient when coordinating
    /// many onboardings, and can be scheduled with a custom
    /// ``requiredPresentationAttempts`` per onboarding.
    ///
    /// Like a standard ``Onboarding``, this onboarding type
    /// is only presented once.
    open class Delayed: Onboarding {

        /// Create a delayed onboarding.
        public init(
            id: String,
            store: UserDefaults = .standard,
            requiredPresentationAttempts: Int
        ) {
            self.requiredPresentationAttempts = requiredPresentationAttempts
            super.init(id: id, store: store)
        }

        /// The number of presentations attempts that is needed.
        public let requiredPresentationAttempts: Int

        open override var shouldBePresented: Bool {
            presentationAttempts == requiredPresentationAttempts
        }

        open override func reset() {
            presentationAttempts = 0
            super.reset()
        }

        open override func tryPresent(
            after seconds: TimeInterval = 0,
            action: @escaping () -> Void
        ) {
            presentationAttempts += 1
            guard shouldBePresented else { return }
            present(after: seconds, action: action)
        }
    }
}

public extension Onboarding.Delayed {

    /// The number of times an onboarding has been attempted.
    var presentationAttempts: Int {
        get { store.integer(forKey: presentationKey) }
        set { store.set(newValue, forKey: presentationKey) }
    }

    /// The number of remaining presentation attempts before
    /// the onboarding will be presented.
    var remainingPresentationAttempts: Int {
        requiredPresentationAttempts - presentationAttempts
    }
}

private extension Onboarding.Delayed {

    var presentationKey: String {
        persistencyKey(for: "presentationAttemptCount")
    }
}


public extension Onboarding {

    static func delayed(
        id: String,
        store: UserDefaults = .standard,
        requiredPresentationAttempts attempts: Int
    ) -> Delayed {
        .init(id: id, store: store, requiredPresentationAttempts: attempts)
    }
}
