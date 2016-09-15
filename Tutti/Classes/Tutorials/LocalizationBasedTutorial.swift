//
//  LocalizationBasedTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-16.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import UIKit

open class LocalizationBasedTutorial: TutorialBase {
   
    
    // MARK: Initialization
    
    public override init(identifier: String) {
        super.init(identifier: identifier)
        pageCount = resolvePageCount()
    }
    
    
    
    // MARK: Private methods
    
    fileprivate func resolvePageCount() -> Int {
        var pageIndex = -1
        var proceed = true
        while (proceed) {
            pageIndex += 1
            let titleKey = super.getResourceName("title", forPageIndex: pageIndex)
            let titleExists = translationExists(titleKey)
            let textKey = super.getResourceName("text", forPageIndex: pageIndex)
            let textExists = translationExists(textKey)
            proceed = titleExists || textExists
        }
        return pageIndex
    }
}
