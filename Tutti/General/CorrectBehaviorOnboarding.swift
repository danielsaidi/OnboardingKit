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
 
 Correct behavior onboardings reset their has been displayed
 memory every time they are presented.
 
 */

import Foundation

public protocol CorrectBehaviorOnboarding: Onboarding {
    
    var registeredIncorrectBehaviors: Int { get set }
    var requiredIncorrectBehaviors: Int { get }
    
    func triggerPresentation(in vc: UIViewController, from view: UIView)
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
    
    func registerIncorrectBehavior(in vc: UIViewController, from view: UIView) {
        registerIncorrectBehavior {
            triggerPresentation(in: vc, from: view)
        }
    }
}


// MARK: - Private Functions

private extension CorrectBehaviorOnboarding {
    
    func registerIncorrectBehavior(showAction: () -> ()) {
        registeredIncorrectBehaviors += 1
        guard remainingAttempts == 0 else { return }
        showAction()
        hasBeenDisplayed = false
        registeredIncorrectBehaviors = 0
    }
}
