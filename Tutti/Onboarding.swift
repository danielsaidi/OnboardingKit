//
//  Onboarding.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This `Onboarding` protocol is implemented by both `Tutorial`
 and `Hint`. It helps keeping track of if a tutorial or hint
 has been displayed or not. If the optional `userId` is used,
 `hasBeenDisplayed` will be unique for every new user.
 
 `Onboarding` also provides translation functionality, which
 can be used by the various hints, tutorials and presenters.
 
 */

import Foundation

public protocol Onboarding: class {

    var identifier: String { get }
    var userId: String? { get }
}


// MARK: - Internal Properties

extension Onboarding {

    var settings: UserDefaults {
        return UserDefaults.standard
    }
    
    var settingsKey: String {
        let key = "com.Tutti.\(identifier)"
        guard let userId = userId else { return key }
        return "\(key).\(userId)"
    }
}


// MARK: - Public Properties

public extension Onboarding {
    
    public var hasBeenDisplayed: Bool {
        get { return settings.bool(forKey: settingsKey) }
        set {
            settings.set(newValue, forKey: settingsKey)
            settings.synchronize()
        }
    }
}


// MARK: - Public Functions

public extension Onboarding {
    
    public func translate(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    public  func translationExists(for key: String) -> Bool {
        return translate(key) != key
    }
}
