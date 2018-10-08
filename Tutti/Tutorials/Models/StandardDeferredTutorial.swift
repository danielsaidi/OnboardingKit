//
//  StandardDeferredTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-06-19.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This is a standard implementation of the `DeferredTutorial`
 protocol. You can use it as is or inherit it to create your
 own specific hint types.
 
 */

import UIKit

open class StandardDeferredTutorial: StandardTutorial, DeferredTutorial {

    
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
