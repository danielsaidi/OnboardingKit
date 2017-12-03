//
//  TutorialBase.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-16.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import Foundation

open class TutorialBase: NSObject, Tutorial {
    

    // MARK: Initialization
    
    public init(identifier: String) {
        self.identifier = identifier
        super.init()
    }
    
    
    
    // MARK: Public Properties
    
    public let identifier: String
    
    public var currentPageIndex = 0

    public var pageCount = 0
    
    
    
    // MARK: Public functions

    open func getResourceName(key: String) -> String {
        return getResourceName(key: key, forPageIndex: currentPageIndex)
    }
    
    open func getResourceName(key: String, forPageIndex index: Int) -> String {
        let trimmed = key.trimmingCharacters(in: .whitespacesAndNewlines)
        let resourceKey = trimmed.isEmpty ? "" : "_\(trimmed)"
        return "tutorial_\(identifier)_\(index)\(resourceKey)"
    }
    
    open func next() -> Bool {
        guard !isLastPage else { return false }
        currentPageIndex += 1
        return true
    }
    
    open func previous() -> Bool {
        guard !isFirstPage else { return false }
        currentPageIndex -= 1
        return true
    }
}



// MARK: - Calculated Properties

public extension TutorialBase {
    
    public var hasBeenDisplayed: Bool {
        get {
            return settings.bool(forKey: hasBeenDisplayedKey)
        }
        set {
            settings.set(newValue, forKey: hasBeenDisplayedKey)
            settings.synchronize()
        }
    }
    
    public var isFirstPage: Bool {
        return currentPageIndex == 0
    }
    
    public var isLastPage: Bool {
        return pageCount == 0 || currentPageIndex == pageCount - 1
    }
}



// MARK: - Private Properties

fileprivate extension TutorialBase {
    
    var settings: UserDefaults {
        return UserDefaults.standard
    }
    
    var hasBeenDisplayedKey: String {
        return "tutorial_\(identifier)_hasBeenDisplayed"
    }
}


