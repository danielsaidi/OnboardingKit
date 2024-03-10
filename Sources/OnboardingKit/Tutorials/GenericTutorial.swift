//
//  GenericTutorial.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2023-12-12.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This ``Tutorial`` subclass defines a generic page type.
 
 Use this class whenever you must use a custom page type, to
 avoid having to cast the type.
 */
open class GenericTutorial<PageType: TutorialPage>: Tutorial {
    
    /// Create a tutorial with a collection of generic pages.
    public init(pages: [PageType]) {
        self.genericPages = pages
        super.init(pages: pages)
    }
    
    public let genericPages: [PageType]
}
