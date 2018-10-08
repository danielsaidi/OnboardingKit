//
//  CorrectBehaviorHint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-10-09.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This is a user behavior-based hint, that is presented after
 a certain number of incorrect user "behaviors". Since it is
 in charge of triggering a presentation, it must be provided
 a presenter, which it will call when needed.
 
 */

import UIKit

open class CorrectBehaviorHint: StandardHint, CorrectBehaviorOnboarding {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        title: String,
        text: String,
        requiredIncorrectBehaviors: Int,
        presenter: HintPresenter,
        userId: String? = nil,
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.requiredIncorrectBehaviors = requiredIncorrectBehaviors
        self.presenter = presenter
        super.init(
            identifier: identifier,
            title: title,
            text: text,
            userId: userId,
            persistence: persistence)
    }
    
    
    // MARK: - Properties
    
    public var registeredIncorrectBehaviors: Int = 0
    
    public let requiredIncorrectBehaviors: Int
    
    public weak var presenter: HintPresenter?
    
    open override var shouldBePresented: Bool {
        return remainingAttempts == 0
    }
    
    
    // MARK: - Functions
    
    public func triggerPresentation(in vc: UIViewController, from view: UIView) {
        presenter?.present(self, in: vc, from: view)
    }
}
