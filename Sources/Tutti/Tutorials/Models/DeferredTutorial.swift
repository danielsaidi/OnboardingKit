//
//  DeferredTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-06-19.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class can be used by any tutorials that should require
 several presentation attempts before being presented.
 
 For more info on how to use it, check out the documentation
 for `DeferredOnboarding`.
 */
open class DeferredTutorial: StandardTutorial, DeferredOnboarding {

    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        pageCount: Int,
        requiredPresentationAttempts: Int,
        userId: String? = nil,
        keySegmentSeparator: String = "_",
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.requiredPresentationAttempts = requiredPresentationAttempts
        super.init(
            identifier: identifier,
            pageCount: pageCount,
            userId: userId,
            keySegmentSeparator: keySegmentSeparator,
            persistence: persistence)
    }
    
    public init(
        fromLocalizationWithPageIndicationKey key: String,
        identifier: String,
        requiredPresentationAttempts: Int,
        userId: String? = nil,
        keySegmentSeparator: String = "_",
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.requiredPresentationAttempts = requiredPresentationAttempts
        super.init(
            fromLocalizationWithPageIndicationKey: key,
            identifier: identifier,
            userId: userId,
            keySegmentSeparator: keySegmentSeparator,
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
