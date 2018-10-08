//
//  CorrectBehaviorOnboarding.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-10-09.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol extends `Onboarding` and can be used when the
 user should see the onboarding experience after a number of
 incorrect "behaviors", e.g. show some help when the user is
 obviously not understanding what to do.
 
 */

import Foundation

public protocol CorrectBehaviorOnboarding: Onboarding {
    
    var registeredIncorrectBehaviors: Int { get set }
    var requiredIncorrectBehaviors: Int { get }
}


// MARK: - Public Properties

public extension CorrectBehaviorOnboarding {
    
    var remainingAttempts: Int {
        return max(0, requiredIncorrectBehaviors - registeredIncorrectBehaviors)
    }
}


// MARK: - Public Functions

public extension CorrectBehaviorOnboarding {
    
    func registerCorrectBehavior() {
        registeredIncorrectBehaviors = 0
    }
    
    func registerIncorrectBehavior() {
        if remainingAttempts == 0 { return }
        registeredIncorrectBehaviors += 1
    }
}
