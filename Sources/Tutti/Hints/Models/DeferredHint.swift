//
//  DeferredHint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-06-19.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class can be used by hints that should require several
 presentation attempts before being presented.
 
 For more info on how to use it, check out the documentation
 for `DeferredOnboarding`.
 */
open class DeferredHint: StandardHint, DeferredOnboarding {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        title: String,
        text: String,
        requiredPresentationAttempts: Int,
        accessibilityText: String? = nil,
        userId: String? = nil,
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.requiredPresentationAttempts = requiredPresentationAttempts
        super.init(
            identifier: identifier,
            title: title,
            text: text,
            accessibilityText: accessibilityText,
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
