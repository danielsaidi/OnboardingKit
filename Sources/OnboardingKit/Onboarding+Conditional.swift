//
//  Onboarding+Conditional.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020-2026 Daniel Saidi. All rights reserved.
//

import Foundation

extension Onboarding {

    /// A conditional onboarding type is only presented when
    /// a condition returns `true`.
    ///
    /// Other than this, this onboarding behaves like a base
    /// ``Onboarding``, and is only presented once.
    /// This onboarding type is only presented if `condition`
    /// returns `true`.
    ///
    /// An example could be a premium feature that will only
    /// show its onboarding after the user has signed up for
    /// a premium subscription.
    ///
    /// Like a standard ``Onboarding``, this onboarding type
    /// is only presented once.
    open class Conditional: Onboarding {

        /// Create a conditional onboarding.
        public init(
            id: String,
            store: UserDefaults = .standard,
            condition: @escaping () -> Bool
        ) {
            self.condition = condition
            super.init(id: id, store: store)
        }

        public let condition: () -> Bool

        /// Whether the onboarding should be presented.
        open override var shouldBePresented: Bool {
            condition() && super.shouldBePresented
        }
    }
}

public extension Onboarding {

    static func conditional(
        id: String,
        store: UserDefaults = .standard,
        condition: @escaping () -> Bool
    ) -> Conditional {
        .init(id: id, store: store, condition: condition)
    }
}
