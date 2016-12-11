//
//  HintBase.swift
//  Tutti
//
//  Created by Daniel Saidi on on 2016-12-11.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//

import Foundation

open class HintBase: NSObject, Hint {
    
    
    // MARK: - Initialization
    
    init(identifier: String, message: String) {
        self.identifier = identifier
        self.message = message
    }
    

    
    // MARK: Public Properties
    
    public let identifier: String
    public let message: String
}



// MARK: - Calculated Properties

public extension HintBase {
    
    public var hasBeenDisplayed: Bool {
        get {
            return settings.bool(forKey: hasBeenDisplayedKey)
        }
        set {
            settings.set(newValue, forKey: hasBeenDisplayedKey)
            settings.synchronize()
        }
    }
}



// MARK: - Private Properties

fileprivate extension HintBase {
    
    var settings: UserDefaults {
        return UserDefaults.standard
    }
    
    var hasBeenDisplayedKey: String {
        return "hint_\(identifier)_hasBeenDisplayed"
    }
}


