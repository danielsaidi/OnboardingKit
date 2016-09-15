//
//  TutorialBase.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-16.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import UIKit

open class TutorialBase: NSObject, Tutorial {
    

    // MARK: Initialization
    
    public init(identifier: String) {
        self.identifier = identifier
        super.init()
    }
    
    
    
    // MARK: Properties
    
    open let identifier: String
    
    open var currentPageIndex = 0
    
    open var hasBeenDisplayed: Bool {
        get { return getDisplayStatus() }
        set { setDisplayStatus(newValue) }
    }

    open var isFirstPage: Bool {
        get { return currentPageIndex == 0 }
    }

    open var isLastPage: Bool {
        get { return pageCount == 0 || currentPageIndex == pageCount - 1 }
    }

    open var pageCount = 0
    
    
    
    // MARK: Private properties
    
    fileprivate var settings: UserDefaults {
        get { return UserDefaults.standard }
    }
    
    fileprivate var defaultsKey: String {
        get { return "tutorial_displayed_\(identifier)" }
    }
    
    
    
    // MARK: Public functions

    open func getResourceName(_ key: String) -> String {
        return getResourceName(key, forPageIndex: currentPageIndex)
    }
    
    open func getResourceName(_ key: String, forPageIndex index: Int) -> String {
        var result = "tutorial_\(identifier)_\(index)"
        if (key.characters.count > 0) {
            result += "_\(key)"
        }
        return result
    }
    
    open func next() -> Bool {
        let nextIsPossible = !isLastPage
        currentPageIndex += nextIsPossible ? 1 : 0
        return nextIsPossible
    }
    
    open func previous() -> Bool {
        let previousIsPossible = !isFirstPage
        currentPageIndex -= previousIsPossible ? 1 : 0
        return previousIsPossible
    }

    
    
    // MARK: Private functions
    
    fileprivate func getDisplayStatus() -> Bool {
        return settings.bool(forKey: defaultsKey)
    }
    
    fileprivate func setDisplayStatus(_ status: Bool) {
        settings.set(status, forKey: defaultsKey)
        settings.synchronize()
    }
}
