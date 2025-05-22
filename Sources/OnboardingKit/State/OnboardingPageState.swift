//
//  OnboardingPageState.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-05-22.
//

import SwiftUI

/// This type can be used to manage an onboarding page state.
///
/// Instead of creating pages and a page index separately, a
/// page state object can be used to manage both.
public class OnboardingPageState<PageModel>: ObservableObject, OnboardingPageManager {

    /// Create an onboarding page state.
    ///
    /// - Parameters:
    ///   - pages: The pages to display in the onboarding.
    public init(
        pages: [PageModel]
    ) {
        self.pages = pages
    }

    /// The pages to display in the onboarding.
    public let pages: [PageModel]

    /// The current page index.
    @Published
    public var currentPageIndex: Int = 0
}

public extension OnboardingPageState {

    /// The total number of pages.
    var totalPageCount: Int { pages.count }
}
