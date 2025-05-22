//
//  OnboardingPageManager.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-05-22.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used to manage onboarding flow pages.
///
/// The protocol is implemented by both ``OnboardingPageInfo``
/// and ``OnboardingPageState``, to share state logic.
public protocol OnboardingPageManager {

    /// The current page index.
    var currentPageIndex: Int { get set }

    /// The total number of pages.
    var totalPageCount: Int { get }
}

public extension OnboardingPageManager {

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
