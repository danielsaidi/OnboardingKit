//
//  OnboardingPageInfo.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2022-09-05.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This type can provide onboarding flow information.
public struct OnboardingPageInfo {
    
    /// Create a page info value.
    ///
    /// - Parameters:
    ///   - pageIndex: The page index.
    ///   - currentPageIndex: The current page index.
    ///   - totalPageCount: The total number of pages.
    public init(
        pageIndex: Int,
        currentPageIndex: Int,
        totalPageCount: Int
    ) {
        self.pageIndex = pageIndex
        self.currentPageIndex = currentPageIndex
        self.totalPageCount = totalPageCount
    }
    
    /// The page index.
    public let pageIndex: Int
    
    /// The current page index.
    public let currentPageIndex: Int
    
    /// The total number of pages.
    public let totalPageCount: Int
}

public extension OnboardingPageInfo {

    /// Whether or not this is the first page.
    var isFirstPage: Bool {
        pageIndex <= 0
    }

    /// Whether or not this is the last page.
    var isLastPage: Bool {
        pageIndex >= totalPageCount - 1
    }

    /// Whether or not the provided page is the current page.
    var isCurrentPage: Bool {
        pageIndex == currentPageIndex
    }
}
