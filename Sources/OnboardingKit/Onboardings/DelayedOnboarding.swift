//
//  DelayedOnboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This onboarding type is only presented after a couple of presentation attempts.
///
/// Delayed onboardings are convenient when you use multiple onboarding types,
/// to schedule how they are presented.
///
/// Other than this, this onboarding type behaves like the base ``Onboarding``,
/// and is only presented once.
open class DelayedOnboarding: Onboarding {
    
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

public extension DelayedOnboarding {

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

private extension DelayedOnboarding {
    
    var presentationKey: String {
        persistencyKey(for: "presentationAttemptCount")
    }
}
