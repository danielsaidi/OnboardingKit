//
//  OnboardingFlow.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 An onboarding flow is made up of one or several pages, that
 can be presented in different ways.
 
 If you need the tutorial to explicitly define its page type,
 you can use the ``GenericOnboardingFlow`` type instead.
 */
open class OnboardingFlow {
    
    /// Create an onboarding flow with a collection of pages.
    public init(pages: [OnboardingPage]) {
        self.pages = pages
    }
    
    public let pages: [OnboardingPage]
}
