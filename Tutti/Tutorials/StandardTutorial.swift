//
//  StandardTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This is a simple implementation of the `Tutorial` protocol.
 You can use it as it is or as a base class for your custom
 tutorials.
 
 */

import Foundation

open class StandardTutorial: Tutorial {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        userId: String? = nil) {
        self.identifier = identifier
        self.userId = userId
    }
    
    
    // MARK: - Properties
    
    public let identifier: String
    public let userId: String?
    
    public fileprivate(set) var currentPageIndex = 0
    public fileprivate(set) var pageCount = 0
    
    
    // MARK: Public functions
    
    open func loadNextPage() -> Bool {
        if isLastPage { return false }
        currentPageIndex += 1
        return true
    }
    
    open func loadPreviousPage() -> Bool {
        if isFirstPage { return false }
        currentPageIndex -= 1
        return true
    }
    
    open func resourceName(for key: String) -> String {
        return resourceName(for: key, pageIndex: currentPageIndex)
    }
    
    open func resourceName(for key: String, pageIndex index: Int) -> String {
        let trimmed = key.trimmingCharacters(in: .whitespacesAndNewlines)
        let resourceKey = trimmed.isEmpty ? "" : "_\(trimmed)"
        return "tutorial_\(identifier)_\(index)\(resourceKey)"
    }
}

