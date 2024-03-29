//
//  DelayedOnboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This onboarding type can be used when the onboarding should
 only be presented after a certain number of attempts.

 Delayed onboardings can be convenient when you want to show
 multiple onboardings, to schedule how they are presented.

 Other than that, this onboarding type behaves just like the
 base ``Onboarding`` and is only presented once.
 */
open class DelayedOnboarding: Onboarding {
    
    /// Create a delayed onboarding instance.
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

public extension Onboarding {

    /// The number of times an onboarding has been attempted.
    var presentationAttempts: Int {
        get { store.integer(forKey: presentationKey) }
        set { store.set(newValue, forKey: presentationKey) }
    }
}

private extension Onboarding {
    
    var presentationKey: String {
        persistencyKey(for: "presentationAttemptCount")
    }
}
