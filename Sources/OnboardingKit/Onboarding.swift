//
//  Onboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This is a base class for different kind of onboarding types.
 
 This class can be used as is, but can also be subclassed to
 create different kind of onboarding experiences.
 
 The default behavior is that ``shouldBePresented`` is `true`
 until a first presentation has been registered, after which
 it becomes `false`. Other onboarding types will however use
 different rules to provide a different experience.
 
 Using an onboarding is easy. Just create an instance of the
 onboarding, and call ``tryPresent(delay:action:)`` when you
 want it to be presented. It will inspect its internal rules
 and state to determine if it should be presented of not.
 
 Call ``reset()`` to reset the onboarding state, at any time.
 */
open class Onboarding: Identifiable {
    
    /// Create an onboarding experience.
    ///
    /// - Parameters:
    ///   - id: The unique onboarding id.
    ///   - defaults: The `UserDefaults` instance to use, by default `.standard`.
    public init(
        id: String,
        defaults: UserDefaults = .standard
    ) {
        self.id = id
        self.defaults = defaults
    }
    
    public typealias UserId = String


    /// The unique onboarding id.
    public let id: String

    /// The `UserDefaults` instance to use.
    public let defaults: UserDefaults


    /// Whether or not the onboarding has been presented.
    open var hasBeenPresented: Bool {
        presentationCount > 0
    }
    
    /// Whether or not the onboarding should be presented.
    open var shouldBePresented: Bool {
        presentationCount == 0
    }
    
    
    /// Register an onboarding presentation.
    ///
    /// The function can be called to manually set the state
    /// of the onboarding, e.g. if a user has indicated that
    /// she/he knows about what it's intended to communicate.
    open func registerPresentation() {
        presentationCount += 1
    }
    
    /// Reset the presentation state of the onboarding.
    open func reset() {
        presentationCount = 0
    }
    
    /// Try to present the onboarding with a certain action.
    ///
    /// The presentation will be ignored if the onboarding's
    /// behavior or state indicates that it does not have to
    /// be presented.
    open func tryPresent(
        after seconds: TimeInterval = 0,
        action: @escaping () -> Void
    ) {
        guard shouldBePresented else { return }
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: .now() + seconds, execute: action)
        registerPresentation()
    }
}

public extension Onboarding {

    /// The number of times an onboarding has been presented.
    var presentationCount: Int {
        get { defaults.integer(forKey: presentationCountKey) }
        set { defaults.set(newValue, forKey: presentationCountKey) }
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
