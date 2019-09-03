//
//  DeferredOnboarding.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be used when an onboarding should require
 many presentations attempts before it is actually presented.
 For instance, you may want to show many hints for a certain
 screen, but distribute them over time.
 */
public protocol DeferredOnboarding: Onboarding {

    var requiredPresentationAttempts: Int { get }
}


// MARK: - Internal Properties

extension DeferredOnboarding {
    
    var registeredPresentationAttemptsKey: String {
        return persistence.key(for: self, objectKey: "presentationAttempts", userId: userId)
    }
}


// MARK: - Public Properties

public extension DeferredOnboarding {
    
    var registeredPresentationAttempts: Int {
        get { return persistence.integer(forKey: registeredPresentationAttemptsKey) }
        set { persistence.set(newValue, forKey: registeredPresentationAttemptsKey) }
    }
    
    var remainingPresentationAttempts: Int {
        return max(0, requiredPresentationAttempts - registeredPresentationAttempts)
    }
}


// MARK: - Public Functions

public extension DeferredOnboarding {
    
    func registerPresentationAttempt() {
        if remainingPresentationAttempts == 0 { return }
        registeredPresentationAttempts += 1
    }
}
