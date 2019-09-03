//
//  Tutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol represents a single or multi page guide, that
 is intended to display more information than a short hint.
 
 Tutorials are perfect for rich modal screen or a multi page
 guides that are intended to be displayed only once, or many
 times if they can be triggered by the user.
 
 When you implement this protocol, `resourceName(for:)` must
 return a valid localized strings key, image name etc. While
 the example app only uses localized strings and images, you
 can use this to identify movie clips, Lottie animations etc.
 
 For more information on how to use this protocol, check out
 the documentation for `Onboarding`.
 */
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
    
    var isFirstPage: Bool {
        guard pageCount > 0 else { return true }
        return currentPageIndex == 0
    }
    
    var isLastPage: Bool {
        guard pageCount > 0 else { return true }
        return currentPageIndex == pageCount - 1
    }
}


// MARK: - Translation Functions

public extension Tutorial {
    
    func translate(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    func translationExists(for key: String) -> Bool {
        return translate(key) != key
    }
}
