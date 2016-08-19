//
//  TutorialBase.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-16.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import UIKit

public class TutorialBase: NSObject, Tutorial {
    

    // MARK: Initialization
    
    public init(identifier: String) {
        self.identifier = identifier
        super.init()
    }
    
    
    
    // MARK: Properties
    
    public let identifier: String
    
    public var currentPageIndex = 0
    
    public var hasBeenDisplayed: Bool {
        get { return getDisplayStatus() }
        set { setDisplayStatus(newValue) }
    }

    public var isFirstPage: Bool {
        get { return currentPageIndex == 0 }
    }

    public var isLastPage: Bool {
        get { return pageCount == 0 || currentPageIndex == pageCount - 1 }
    }

    public var pageCount = 0
    
    
    
    // MARK: Private properties
    
    private var settings: NSUserDefaults {
        get { return NSUserDefaults.standardUserDefaults() }
    }
    
    private var defaultsKey: String {
        get { return "tutorial_displayed_\(identifier)" }
    }
    
    
    
    // MARK: Public functions

    public func getResourceName(key: String) -> String {
        return getResourceName(key, forPageIndex: currentPageIndex)
    }
    
    public func getResourceName(key: String, forPageIndex index: Int) -> String {
        var result = "tutorial_\(identifier)_\(index)"
        if (key.characters.count > 0) {
            result += "_\(key)"
        }
        return result
    }
    
    public func next() -> Bool {
        let nextIsPossible = !isLastPage
        currentPageIndex += nextIsPossible ? 1 : 0
        return nextIsPossible
    }
    
    public func previous() -> Bool {
        let previousIsPossible = !isFirstPage
        currentPageIndex -= previousIsPossible ? 1 : 0
        return previousIsPossible
    }

    
    
    // MARK: Private functions
    
    private func getDisplayStatus() -> Bool {
        return settings.boolForKey(defaultsKey)
    }
    
    private func setDisplayStatus(status: Bool) {
        settings.setBool(status, forKey: defaultsKey)
        settings.synchronize()
    }
}
