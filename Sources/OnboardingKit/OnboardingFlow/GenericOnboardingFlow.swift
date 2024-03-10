//
//  GenericOnboardingFlow.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2023-12-12.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This ``OnboardingFlow`` uses generic page types.
 
 You can use this class to use an explicit, custom page type,
 to avoid having to cast the page type in e.g. view builders.
 */
open class GenericOnboardingFlow<PageType: OnboardingPage>: OnboardingFlow {
    
    /// Create a tutorial with a collection of generic pages.
    public init(pages: [PageType]) {
        self.genericPages = pages
        super.init(pages: pages)
    }
    
    public let genericPages: [PageType]
}
