//
//  Onboarding+Conditional.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

extension Onboarding {

    /// This onboarding type is only presented if bool condition returns `true`.
    ///
    /// One example could be a premium feature onboarding that is only shown
    /// after the user signs up for a premium subscription.
    ///
    /// Other than this, this onboarding behaves like a base ``Onboarding``,
    /// and is only presented once.
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

        /// Whether or not the onboarding should be presented.
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
