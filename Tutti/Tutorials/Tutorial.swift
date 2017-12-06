//
//  Tutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*

 Unlike hints, tutorials are single- or multi-page guides. A
 tutorial can be used to introduce users to an entire app or
 to features that requires more info than just a single line
 of text. Like hints, tutorials are intended to be displayed
 only once.
 
 The `resourceName(for:)` function should return valid names
 for localized strings, images etc. The function should also
 take the current page into consideration.
 
 `StandardTutorial` provides you with a small implementation
 of this protocol.
 
 */

import Foundation

public protocol Tutorial: Displayable {

    var currentPageIndex: Int { get }
    var pageCount: Int { get }
    
    func loadNextPage() -> Bool
    func loadPreviousPage() -> Bool
    func resourceName(for key: String) -> String
}


// MARK: - Public Functions

public extension Tutorial {

    public var isFirstPage: Bool {
        guard pageCount > 0 else { return true }
        return currentPageIndex == 0
    }
    
    public var isLastPage: Bool {
        guard pageCount > 0 else { return true }
        return currentPageIndex == pageCount - 1
    }
}
