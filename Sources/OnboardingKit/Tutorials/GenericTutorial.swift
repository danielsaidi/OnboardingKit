//
//  GenericTutorial.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2023-12-12.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This tutorial type inherits the ``Tutorial`` base class and
 specifies a generic page type.
 
 You can use this tutorial type if you need an explicit page
 type to avoid casting.
 */
open class GenericTutorial<PageType: TutorialPage>: Tutorial {
    
    /**
     Create a tutorial with a fixed set of pages.
     */
    public init(pages: [PageType]) {
        self.genericPages = pages
        super.init(pages: pages)
    }
    
    public let genericPages: [PageType]
}
