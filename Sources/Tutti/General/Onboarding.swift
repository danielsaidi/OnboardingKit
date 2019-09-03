//
//  Onboarding.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is a base protocol for onboarding experiences,
 like tutorials and hints. It provides you with ways to keep
 track of if an onboarding has been displayed or not.
 
 If the optional `userId` property is set, `hasBeenDisplayed`
 value is unique for every user.
 */
public protocol Onboarding: class {
    
    var identifier: String { get }
    var userId: String? { get }
    var persistence: OnboardingPersistence { get }
    
    var shouldBePresented: Bool { get }
    
    func prepareForPresentation()
}


// MARK: - Internal Properties

extension Onboarding {
    
    var hasBeenDisplayedKey: String {
        return persistence.key(for: self, objectKey: "hasBeenDisplayed", userId: userId)
    }
}


// MARK: - Public Properties

public extension Onboarding {
    
    var hasBeenDisplayed: Bool {
        get { return persistence.bool(forKey: hasBeenDisplayedKey) }
        set { persistence.set(newValue, forKey: hasBeenDisplayedKey) }
    }
}
