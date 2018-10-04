//
//  StandardTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This is a simple `Tutorial` implementation. Use it as is or
 as a base for any custom tutorials.
 
 You can create a standard tutorial, either by providing all
 property values, or by using a localization page indication
 key and automatically calculate the page count depending on
 the existing translations that exist.
 
 When you use the location-based approach, this class starts
 at page 0 and looks for the `pageIndicationKey` translation
 in `Localized.strings` for that page. It will then bump the
 index until it cannot find a translation for a certain page.
 The default key indicator value is `title`, and the default
 key segment separator is `_` but you can use any values you
 like. If you use these values, however, a tutorial with the
 identifier `myTutorial` will get two pages if the following
 language keys exist in `Localized.strings`:
 
 * tutorial_myTutorial_0_title
 * tutorial_myTutorial_1_title
 
 You can subclass this class and override the initializer if
 you want this automatic handling to behave differently.
 
 */

import UIKit

open class StandardTutorial: Tutorial {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        pageCount: Int,
        userId: String? = nil,
        keySegmentSeparator: String = "_",
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.identifier = identifier
        self.pageCount = pageCount
        self.userId = userId
        self.keySegmentSeparator = keySegmentSeparator
        self.persistence = persistence
    }
    
    public init(
        fromLocalizationWithPageIndicationKey key: String,
        identifier: String,
        userId: String? = nil,
        keySegmentSeparator: String = "_",
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.identifier = identifier
        self.pageCount = -1
        self.userId = userId
        self.keySegmentSeparator = keySegmentSeparator
        self.persistence = persistence
        pageCount = resolvePageCount(withPageIndicationKey: key)
    }
    
    
    // MARK: - Properties
    
    public let identifier: String
    public let keySegmentSeparator: String
    public var pageCount: Int
    public let userId: String?
    
    public var currentPageIndex = 0
    
    public var persistence: OnboardingPersistence
    
    public var shouldBePresented: Bool {
        return !hasBeenDisplayed
    }
    
    
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
    
    open func prepareForPresentation() {}
    
    open func resourceName(for key: String, at pageIndex: Int) -> String {
        let key = key.trimmingCharacters(in: .whitespaces)
        var segments = ["tutorial", identifier, "\(pageIndex)"]
        if key.count > 0 { segments.append(key) }
        return segments.joined(separator: keySegmentSeparator)
    }
}


// MARK: - Private Functions

fileprivate extension StandardTutorial {
    
    func resolvePageCount(withPageIndicationKey key: String) -> Int {
        var index = 0
        while translationExists(for: resourceName(for: key, at: index)) {
            index += 1
        }
        return index
    }
}
