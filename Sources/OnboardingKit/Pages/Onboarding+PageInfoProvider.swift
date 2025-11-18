//
//  Onboarding+PageInfoProvider.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-05-22.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Onboarding {

    /// This protocol can be implemented by types that can be used to manage
    /// the page information of a multi-page onboarding.
    protocol PageInfoProvider {

        /// The current page index.
        var currentPageIndex: Int { get set }

        /// The total number of pages.
        var totalPageCount: Int { get }
    }
}

public extension Onboarding.PageInfoProvider {

    /// Whether the current page is the first page.
    var isCurrentPageFirst: Bool {
        isFirstPage(currentPageIndex)
    }

    /// Whether the current page is the last page.
    var isCurrentPageLast: Bool {
        isLastPage(currentPageIndex)
    }

    /// Whether a certain page index is the first page.
    func isFirstPage(_ index: Int) -> Bool {
        currentPageIndex <= 0
    }

    /// Whether a certain page index is the last page.
    func isLastPage(_ index: Int) -> Bool {
        index >= totalPageCount - 1
    }
}
