//
//  Tutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*

 A tutorial is a single or multi page guide that is intended
 to display more information than a quick hint. It's perfect
 for a rich modal screen or a multi page guide that explains
 how an entire app works. Like hints, tutorials are intended
 to be displayed once.
 
 When implementing this protocol, `resourceName(for)` should
 return valid localized strings keys, image names etc. While
 the example app only uses localized strings and images, you
 can use this to identify movie clips, Lottie animations etc.
 
 */

import Foundation

public protocol Tutorial: Onboarding {
    
    var currentPageIndex: Int { get set }
    var keySegmentSeparator: String { get }
    var pageCount: Int { get }
    
    func loadNextPage() -> Bool
    func loadPreviousPage() -> Bool
    func resourceName(for key: String, at pageIndex: Int) -> String
}


// MARK: - Public Properties

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


// MARK: - Public Functions

public extension Tutorial {
    
    public func string(for key: String, at pageIndex: Int) -> String {
        var page = pageIndex
        
        while page > 0 {
            let resource = resourceName(for: key, at: page)
            if translationExists(for: resource) {
                return translate(resource)
            }
            page -= 1
        }
        
        return ""
    }
}
