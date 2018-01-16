//
//  Displayable.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 The `Displayable` protocol is implemented by `Tutorial` and
 `Hint`. It helps determining if a tutorial or hint has been
 displayed to the current user.
 
 If the optional `userId` is set, `hasBeenDisplayed` will be
 false for every new user.
 
 */

import Foundation

public protocol Displayable {

    var identifier: String { get }
    var userId: String? { get }
}


// MARK: - Internal Properties

extension Displayable {

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

public extension Displayable {
    
    public var hasBeenDisplayed: Bool {
        get { return settings.bool(forKey: settingsKey) }
        set {
            settings.set(newValue, forKey: settingsKey)
            settings.synchronize()
        }
    }
}
