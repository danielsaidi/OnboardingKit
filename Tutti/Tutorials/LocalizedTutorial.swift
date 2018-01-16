//
//  LocalizedTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This class automatically generates a multi-page tutorial by
 using available language keys in the current app. It's just
 a convenience layer ontop `StandardTutorial`, if you do not
 want to have to keep the page count in sync when adding new
 page translations to `Localized.strings`.
 
 When initialized, this class will start at page index 0 and
 look for the existence of a `pageIndicationKey` translation
 key in `Localized.strings` for that page. It will then bump
 the index until it can not find one for a certain page. You
 will then have a tutorial the correct number of pages.
 
 The default key indicator value is `title`, and the default
 key segment separator is `_` but you can use any values you
 like. However, if you use the defaults, a tutorial with the
 identifier "myTutorial" will get two pages if the following
 language keys exist in `Localized.strings`:
 
 * tutorial_myTutorial_0_title
 * tutorial_myTutorial_1_title
 
 Subclass this class and override `getResourceName` if you'd
 like to use another naming pattern.
 
 */

import Foundation

open class LocalizedTutorial: StandardTutorial {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        userId: String? = nil,
        pageIndicationKey: String = "title",
        keySegmentSeparator: String = "_") {
        self.pageIndicationKey = pageIndicationKey
        super.init(
            identifier: identifier,
            pageCount: 0,
            userId: userId,
            keySegmentSeparator: keySegmentSeparator)
        pageCount = resolvePageCount()
    }
    
    
    // MARK: - Properties
    
    public let pageIndicationKey: String
}


// MARK: - Private Functions

fileprivate extension LocalizedTutorial {
    
    func resolvePageCount() -> Int {
        var pageIndex = 0
        while translationExists(for: resourceName(for: pageIndex)) {
            pageIndex += 1
        }
        return pageIndex
    }
    
    func resourceName(for pageIndex: Int) -> String {
        return resourceName(for: pageIndicationKey, pageIndex: pageIndex)
    }
    
    func translationExists(for key: String) -> Bool {
        let result = NSLocalizedString(key, comment: "")
        return result != key
    }
}
