//
//  DelayedOnboarding.swift
//  Tutti
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This onboarding type can be used when the onboarding should
 be presented after a number of presentation attempts.

 Delayed onboardings can be convenient when you need to show
 multiple onboardings. You can then use the requires attemts
 as a way to schedule how the onboardings are presented. You
 can also use a delayed onboarding if you don't want to show
 it immediately.

 ``shouldBePresented`` becomes `true` only after it has been
 called a number of times, either by calling it directly, or
 by calling ``Onboarding/tryPresent(presentAction:)``.

 Other than that, this onboarding type behaves just like the
 base ``Onboarding`` and is only presented once.
 */
open class DelayedOnboarding: Onboarding {
    
    /**
     Create a delayed onboarding experience.
     
     - Parameters:
       - id: The unique onboarding id.
       - userId: An optional user id, by default `nil`.
       - defaults: The `UserDefaults` instance to use, by default `.standard`.
       - requiredPresentationAttempts: The number of attempts required before the onboarding is presented.
     */
    public init(
        id: String,
        userId: UserId? = nil,
        defaults: UserDefaults = .standard,
        requiredPresentationAttempts: Int) {
        self.requiredPresentationAttempts = requiredPresentationAttempts
        super.init(id: id, userId: userId, defaults: defaults)
    }


    /**
     The number of presentation attempts required before the
     onboarding is presented.
     */
    public let requiredPresentationAttempts: Int
    
    
    /**
     Whether or not the onboarding should be presented.

     Checking this property will automatically increment the
     counter that eventually causes it to become `true`.
     */
    open override var shouldBePresented: Bool {
        presentationCheckCount += 1
        let isActive = presentationCheckCount >= requiredPresentationAttempts
        return isActive && super.shouldBePresented
    }

    /**
     Reset the onboarding state.
     */
    open override func reset() {
        presentationCheckCount = 0
        super.reset()
    }
}


// MARK: - Public Members

public extension DelayedOnboarding {

    /**
     The number of times a presentation has been attempted.
     */
    var presentationCheckCount: Int {
        get { defaults.integer(forKey: presentationCheckCountKey) }
        set { defaults.set(newValue, forKey: presentationCheckCountKey) }
    }
}


// MARK: - Private Mebers

private extension DelayedOnboarding {
    
    var presentationCheckCountKey: String {
        persistencyKey(for: "presentationCheckCount")
    }
}
