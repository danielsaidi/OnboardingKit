//
//  CorrectBehaviorOnboarding.swift
//  Tutti
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This onboarding can be used to help a user behave correctly
 e.g. by presenting a hint about what you are expected to do.
 
 An example could be a puzzle game, where a piece can be set
 to move to the correct place after being incorrectly placed
 a certain number of times.
 
 `registerIncorrectBehavior` should be triggered each time a
 user behaves incorrectly. `shouldBePresented` becomes `true`
 when this has been repeated a certain number of times.
 
 `registerCorrectBehavior` should be triggered when the user
 behaves correctly. It will cancel any previously registered
 incorrect behaviors.
 
 The class will reset every time it registers a presentation,
 since users should continue to see the hint if they keep on
 behaving incorrectly.
 */
open class CorrectBehaviorOnboarding: Onboarding {
    
    /**
     Create a delayed onboarding experience.
     
     - Parameters:
        - id: The unique onboarding id.
        - userId: An optional user id.
        - defaults: The `UserDefaults` instance to use.
        - requiredIncorrectAttempts: The number of times `registerIncorrectBehavior` must be checked before `shouldBePresented` becomes `true`.
     */
    public init(
        id: String,
        userId: UserId? = nil,
        defaults: UserDefaults = .standard,
        requiredIncorrectAttempts: Int) {
        self.requiredIncorrectAttempts = requiredIncorrectAttempts
        super.init(id: id, userId: userId, defaults: defaults)
    }
    
    private let requiredIncorrectAttempts: Int
    
    /**
     Whether or not the onboarding should be presented.
     */
    open override var shouldBePresented: Bool {
        incorrectBehaviorCount >= requiredIncorrectAttempts
    }
    
    /**
     Register a correct user behavior, which will cause this
     onboarding to reset itself.
     */
    open func registerCorrectBehavior() {
        reset()
    }
    
    /**
     Register an incorrect user behavior. This will make the
     onboarding increment the `incorrectBehaviorCount` which
     may cause `shouldBePresented` to become `true`.
     */
    open func registerIncorrectBehavior() {
        incorrectBehaviorCount += 1
    }
    
    /**
     Call this when you present the onboarding. It will make
     the onboarding reset, so that it can be presented again.
     */
    open override func registerPresentation() {
        reset()
    }
    
    /**
     Call this to reset any previous presentation logic.
     */
    open override func reset() {
        incorrectBehaviorCount = 0
        super.reset()
    }
}


// MARK: - Public Members

public extension CorrectBehaviorOnboarding {
    
    var incorrectBehaviorCount: Int {
        get { defaults.integer(forKey: incorrectBehaviorCountKey) }
        set { defaults.set(newValue, forKey: incorrectBehaviorCountKey) }
    }
}


// MARK: - Private Mebers

private extension CorrectBehaviorOnboarding {
    
    var incorrectBehaviorCountKey: String {
        persistencyKey(for: "incorrectBehaviorCount")
    }
}
