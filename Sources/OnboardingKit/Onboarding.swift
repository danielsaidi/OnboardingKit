//
//  Onboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This is a base class for different onboarding types.
///
/// This class can be used as is, but can also be subclassed
/// to create different kind of onboarding experiences.
///
/// The default state is that ``shouldBePresented`` is `true`
/// until a first presentation is registered, after which it
/// becomes `false`. Other onboarding types will however use
/// different rules to provide a different experience.
///
/// Using the onboarding is easy. Just create an instance of
/// the specific onboarding type you want to use and trigger
/// ``tryPresent(after:action:)`` to try to present it. This
/// will inspect the internal onboarding rules and will only
/// perform the presentation action if needed.
///
/// Call ``reset()`` to reset the onboarding state.
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
    
    
    /// Whether or not the onboarding should be presented.
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
