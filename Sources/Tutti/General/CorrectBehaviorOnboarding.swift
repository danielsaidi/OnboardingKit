//
//  CorrectBehaviorOnboarding.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-10-09.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be used when the user should be presented
 with an onboarding experience after a number of "incorrect"
 actions, e.g. when not doing what she/he is supposed to do.
 
 To use this protocol, call `registerIncorrectBehavior(...)`
 each time the user behaves incorrectly. If the user behaves
 incorrectly `requiredIncorrectBehaviors` number of times, a
 presentation is triggererd. Call `registerCorrectBehavior()`
 to reset the registered number of incorrect behaviors.
 
 This onboarding will also reset its memory every time it is
 presented. This means that it will be displayed again, if a
 user keeps behaving in a way that is not intended.
 */
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
