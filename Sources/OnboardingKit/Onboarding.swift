//
//  Onboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017-2026 Daniel Saidi. All rights reserved.
//

import Foundation

/// This is a base class for different onboarding types.
///
/// This class can be used as a regular onboarding, which is
/// only presended once, but it can be inherited to create a
/// custom experiences, like ``Delayed`` and ``Conditional``.
///
/// The ``shouldBePresented`` is `true` by default until the
/// first presentation has been registered, after which this
/// value becomes `false`. Custom onboarding types can apply
/// different rules to provide custom behaviors.
///
/// Using this model is easy. Just create an instance of the
/// onboarding type that you want to use, and simply trigger
/// ``tryPresent(after:action:)`` to present it. This causes
/// the app to check the internal onboarding rules, and only
/// performs the presentation action if needed.
///
/// You can call ``reset()`` to reset the current state of a
/// certain onboarding.
open class Onboarding: Identifiable {
    
    /// Create a standard onboarding.
    public init(
        id: String,
        store: UserDefaults = .standard
    ) {
        self.id = id
        self.store = store
    }


    /// The unique onboarding id.
    public let id: String

    /// The `UserDefaults` instance to use.
    public let store: UserDefaults
    
    
    /// Whether the onboarding should be presented.
    open var shouldBePresented: Bool {
        presentationCount == 0
    }
    
    /// Reset the presentation state of the onboarding.
    open func reset() {
        presentationCount = 0
    }
    
    /// Try to present the onboarding with a provided action,
    /// after an optional delay.
    ///
    /// The presentation will be ignored when the onboarding
    /// does not have to be presented.
    @MainActor
    open func tryPresent(
        after seconds: TimeInterval = 0,
        action: @escaping () -> Void
    ) {
        guard shouldBePresented else { return }
        present(after: seconds, action: action)
    }
    
    /// Present the onboarding with the provided action.
    @MainActor
    open func present(
        after seconds: TimeInterval = 0,
        action: @escaping () -> Void
    ) {
        presentationCount += 1
        if seconds > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                action()
            }
        } else {
            action()
        }
    }
}

public extension Onboarding {

    /// The number of times an onboarding has been presented.
    var presentationCount: Int {
        get { store.integer(forKey: presentationCountKey) }
        set { store.set(newValue, forKey: presentationCountKey) }
    }
    
    /// The unique storage key to use for persisting values.
    func persistencyKey(for key: String) -> String {
        "com.onboardingkit.onboarding.\(id).\(key)"
    }
}

private extension Onboarding {
    
    var presentationCountKey: String {
        persistencyKey(for: "presentationCount")
    }
}
