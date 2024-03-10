//
//  CorrectBehaviorOnboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This onboarding type can help users behave as expected, for
 instance by presenting a hint about what you're expected to
 do after you fail to do so a certain number of times.
 
 An example could be a puzzle game, where pieces can animate
 to their position after being incorrectly placed many times.

 Unlike the base ``Onboarding``, this onboarding resets once
 it's presented, since users should get the onboarding again
 if they keep behaving in an incorrect way.

 Call ``registerIncorrectBehavior()`` when users behave in a
 way that you think is incorrect. ``shouldBePresented`` will
 become `true` when it has been called a couple of times, as
 defined by the ``requiredIncorrectAttempts`` property.

 Call ``registerCorrectBehavior()`` when users behave as you
 want them to. It cancels all registered incorrect behaviors
 and makes the onboarding start from the beginning.
 */
open class CorrectBehaviorOnboarding: Onboarding {
    
    /**
     Create a delayed onboarding experience.
     
     - Parameters:
        - id: The unique onboarding id.
        - defaults: The `UserDefaults` instance to use.
        - requiredIncorrectAttempts: The number of incorrect attempts before the onboarding is presented.
     */
    public init(
        id: String,
        defaults: UserDefaults = .standard,
        requiredIncorrectAttempts: Int
    ) {
        self.requiredIncorrectAttempts = requiredIncorrectAttempts
        super.init(id: id, defaults: defaults)
    }


    /**
     The number of times users can behave incorrectly before
     the onboarding is presented.
     */
    public let requiredIncorrectAttempts: Int


    /**
     Whether or not the onboarding should be presented.

     This becomes `true` when ``registerIncorrectBehavior()``
     has been called a certain number of times.
     */
    open override var shouldBePresented: Bool {
        incorrectBehaviorCount >= requiredIncorrectAttempts
    }
    
    /**
     Register a correct behavior.

     Calling this function indicates that a user has behaved
     as expected, which will cause any previously registered
     incorrect behaviors to reset and the onboarding restart.
     */
    open func registerCorrectBehavior() {
        reset()
    }
    
    /**
     Register an incorrect behavior.

     Calling this function indicates that a user has behaved
     incorrectly, which increments a counter that eventually
     will makes ``shouldBePresented`` become `true`.
     */
    open func registerIncorrectBehavior() {
        incorrectBehaviorCount += 1
    }
    
    /**
     Register an onboarding presentation.

     This onboarding will reset itself for each presentation,
     since users who keep behaving incorrectly should see it
     over and over again.
     */
    open override func registerPresentation() {
        reset()
    }
    
    /**
     Reset the onboarding state.
     */
    open override func reset() {
        incorrectBehaviorCount = 0
        super.reset()
    }
}


// MARK: - Public Members

public extension CorrectBehaviorOnboarding {

    /**
     The number of times an incorrect behavior has been done.
     */
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
