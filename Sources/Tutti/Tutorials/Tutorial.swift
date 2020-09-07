//
//  Tutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A `tutorial` is a single or multi page onboarding guide. It
 is intended to show more information than short `hint`s and.
 is perfect for a modal screen or a multi page guide.
 */
open class Tutorial<Page: TutorialPage> {
    
    /**
     Create a tutorial with a fixed set of pages.
     */
    public init(pages: [Page]) {
        self.pages = pages
    }
    
    public let pages: [Page]
}
