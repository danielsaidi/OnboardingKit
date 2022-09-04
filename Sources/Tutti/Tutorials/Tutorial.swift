//
//  Tutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A tutorial is a single or multi-page onboarding guide, that
 is intended to show more information than short a hint.
 */
open class Tutorial<PageType: TutorialPage> {
    
    /**
     Create a tutorial with a fixed set of pages.
     */
    public init(pages: [PageType]) {
        self.pages = pages
    }
    
    public let pages: [PageType]
}
