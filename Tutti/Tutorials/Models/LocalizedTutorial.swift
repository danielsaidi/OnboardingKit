//
//  LocalizedTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This class automatically generates a multi-page tutorial by
 using available language keys in the current app.
 
 When initialized, this class will start at page index 0 and
 look for the existence of a `pageIndicationKey` translation
 in `Localized.strings` for that page. It will then bump the
 index until it cannot find a translation for a certain page.
 You will then have a correctly setup tutorial.
 
 The default key indicator value is `title`, and the default
 key segment separator is `_` but you can use any values you
 like. If you use these values, however, a tutorial with the
 identifier `myTutorial` will get two pages if the following
 language keys exist in `Localized.strings`:
 
 * tutorial_myTutorial_0_title
 * tutorial_myTutorial_1_title
 
 Subclass this class and override `getResourceName` if you'd
 like to use another naming pattern.
 
 */

import Foundation

@available(*, deprecated, message: "LocalizedTutorial is deprecated. Use the localization-based StandardTutorial initializer instead")
open class LocalizedTutorial: StandardTutorial {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        userId: String? = nil,
        pageIndicationKey key: String = "title",
        keySegmentSeparator: String = "_") {
        super.init(
            fromLocalizationWithPageIndicationKey: key,
            identifier: identifier,
            userId: userId,
            keySegmentSeparator: keySegmentSeparator)
    }
}
