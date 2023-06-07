//
//  Onboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This is a base class for various onboarding experiences. It
 can be used as is or subclassed to create different kind of
 onboarding experiences.
 
 The basic onboarding behavior is that ``shouldBePresented``
 is `true` until the first presentation is registered, after
 which it becomes `false`. The onboarding must then be reset
 with ``reset()`` before you can present it again.

 You can call ``registerPresentation()`` to register when an
 onboarding has been presented, if you handle a presentation
 manually. This will persist this presentation state for the
 onboarding and make sure that it isn't presented again. You
 can also call ``tryPresent(presentAction:)`` to perform the
 provided action if the onboarding should be presented. This
 causes the presentation to be automatically registered.
 */
open class Onboarding {
    
    /**
     Create an onboarding experience.
     
     - Parameters:
        - id: The unique onboarding id.
        - userId: An optional user id, by default `nil`.
        - defaults: The `UserDefaults` instance to use, by default `.standard`.
     */
    public init(
        id: String,
        userId: UserId? = nil,
        defaults: UserDefaults = .standard) {
        self.id = id
        self.userId = userId
        self.defaults = defaults
    }
    
    public typealias UserId = String


    /// The unique onboarding id.
    public let id: String

    /// An optional user id.
    public let userId: UserId?

    /// The `UserDefaults` instance to use.
    public let defaults: UserDefaults


    /**
     Whether or not the onboarding has been presented.
     */
    open var hasBeenPresented: Bool {
        presentationCount > 0
    }
    
    /**
     Whether or not the onboarding should be presented.

     This behavior can be overridden by the onboarding types.
     */
    open var shouldBePresented: Bool {
        presentationCount == 0
    }
    
    /**
     Register an onboarding presentation.

     This is also called when ``tryPresent(presentAction:)``
     successfully performs a presentation action.

     Registering a presentation has different effects on the
     various types. The base ``Onboarding`` and a few of its
     subclasses types will not be presented again until they
     are reset, while others behave differently.
     */
    open func registerPresentation() {
        presentationCount += 1
    }
    
    /**
     Reset the onboarding state.
     */
    open func reset() {
        presentationCount = 0
    }
    
    /**
     Try to presenting the onboarding with a certain `action`.

     The presentation attempt is aborted when the onboarding
     should not be presented.
     */
    open func tryPresent(presentAction action: () -> Void) {
        guard shouldBePresented else { return }
        action()
        registerPresentation()
    }

    /**
     Try to presenting the onboarding with a certain `action`
     after a certain amount of `seconds`.

     The presentation attempt is aborted when the onboarding
     should not be presented.
     */
    open func tryPresent(
        after seconds: TimeInterval,
        presentAction action: @escaping () -> Void
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            self?.tryPresent(presentAction: action)
        }
    }
}


// MARK: - Public Members

public extension Onboarding {

    /**
     The number of times a presentation has been registered.
     */
    var presentationCount: Int {
        get { defaults.integer(forKey: presentationCountKey) }
        set { defaults.set(newValue, forKey: presentationCountKey) }
    }
    
    /**
     The key to use for persisting values. The key is unique
     for each onboarding and user.
     */
    func persistencyKey(for key: String) -> String {
        let key = "com.onboardingkit.onboarding.\(id).\(key)"
        guard let userId = userId else { return key }
        return "\(key).\(userId)"
    }
}


// MARK: - Private Mebers

private extension Onboarding {
    
    var presentationCountKey: String {
        persistencyKey(for: "presentationCount")
    }
}
