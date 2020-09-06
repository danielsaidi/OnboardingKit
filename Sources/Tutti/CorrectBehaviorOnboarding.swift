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
 
 An example can be a puzzle game for kids, where a piece can
 move to the correct place after a child has placed it wrong
 a certain number of times.
 
 Trigger `registerIncorrectBehavior` every time users behave
 "incorrectly". `shouldBePresented` becomes `true` when this
 has been repeated a certain number of times. Also make sure
 to trigger `registerCorrectBehavior` each time users behave
 "correctly", to cancel out any previous incorrect behavior.
 
 The class will reset every time it registers a presentation,
 since users should continue to see the hint if they keep on
 behavior incorrectly.
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
