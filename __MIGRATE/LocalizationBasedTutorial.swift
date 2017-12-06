//
//  LocalizationBasedTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-16.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

/*
 
 This class automatically generates multi-page tutorials
 by looping through the language keys in an app.
 
 When initialized, the class will look for the existence
 of an pageIndicationKey string resource until it cannot
 find one for a certain page. The default value for this
 key is "title", but you can use any value.
 
 The default language key name for a certain resource is:
 "tutorial_(identifier)_(index)_(resource). That means a
 tutorial with the identifier "myTutorial" would get two
 pages if the following language keys existed:
 
 - tutorial_myTutorial_0_title
 - tutorial_myTutorial_1_title
 
 Subclass this class and override getResourceName if you
 want to use another naming pattern.
 
 */

import Foundation

open class LocalizationBasedTutorial: TutorialBase {
   
    
    // MARK: Initialization
    
    public init(identifier: String, pageIndicationKey: String = "title") {
        super.init(identifier: identifier)
        pageCount = resolvePages(with: pageIndicationKey)
    }
}



// MARK: - Private Functions

fileprivate extension LocalizationBasedTutorial {
    
    func resolvePages(with key: String) -> Int {
        var pageIndex = -1
        var proceed = true
        while (proceed) {
            pageIndex += 1
            let languageKey = getResourceName(key: key, forPageIndex: pageIndex)
            proceed = translationExists(languageKey)
        }
        return pageIndex
    }
}
