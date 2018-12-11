//
//  DeferredHint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-06-19.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This is a deferred hint that is presented after a number of
 presentation attempts.
 
 */

import UIKit

open class DeferredHint: StandardHint, DeferredOnboarding {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        title: String,
        text: String,
        requiredPresentationAttempts: Int,
        userId: String? = nil,
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.requiredPresentationAttempts = requiredPresentationAttempts
        super.init(
            identifier: identifier,
            title: title,
            text: text,
            userId: userId,
            persistence: persistence)
    }
    
    
    // MARK: - Properties
    
    public let requiredPresentationAttempts: Int
    
    open override var shouldBePresented: Bool {
        return super.shouldBePresented && remainingPresentationAttempts == 0
    }
    
    
    // MARK: - Public Functions
    
    open override func prepareForPresentation() {
        registerPresentationAttempt()
    }
}
