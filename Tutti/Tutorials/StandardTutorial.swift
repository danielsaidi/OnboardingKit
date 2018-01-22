//
//  StandardTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This is a simple implementation of the `Tutorial` protocol.
 You can use it as it is, or as a base class for any custom
 tutorials.
 
 */

import Foundation

open class StandardTutorial: Tutorial {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        pageCount: Int,
        userId: String? = nil,
        keySegmentSeparator: String = "_") {
        self.identifier = identifier
        self.pageCount = pageCount
        self.userId = userId
        self.keySegmentSeparator = keySegmentSeparator
    }
    
    
    // MARK: - Properties
    
    public let identifier: String
    public let keySegmentSeparator: String
    public var pageCount: Int
    public let userId: String?
    
    public var currentPageIndex = 0
    
    
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
    
    open func resourceName(for key: String, at pageIndex: Int) -> String {
        let key = key.trimmingCharacters(in: .whitespaces)
        var segments = ["tutorial", identifier, "\(pageIndex)"]
        if key.count > 0 { segments.append(key) }
        return segments.joined(separator: keySegmentSeparator)
    }
}
