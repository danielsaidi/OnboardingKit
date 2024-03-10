//
//  Tutorial.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A tutorial is a single or multi-page onboarding guide, that
 is intended to show more information than short a hint.
 
 This tutorial base class uses ``TutorialPage`` as page type.
 You can pass in any page that inherits ``TutorialPage``, so
 it should suffice in most cases.
 
 If you need the tutorial to explicitly define its page type,
 you can use the ``GenericTutorial`` type instead.
 */
open class Tutorial {
    
    /// Create a tutorial with a collection of pages.
    public init(pages: [TutorialPage]) {
        self.pages = pages
    }
    
    public let pages: [TutorialPage]
}
