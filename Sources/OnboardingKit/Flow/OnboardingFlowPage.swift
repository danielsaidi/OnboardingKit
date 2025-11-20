//
//  OnboardingFlow+PageInfo.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2022-09-05.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This type defines page info for an onboarding page.
public struct OnboardingFlowPage<PageModel>: OnboardingFlow.PageInfoProvider {

    /// Create a page info value.
    ///
    /// - Parameters:
    ///   - page: The page value.
    ///   - pageIndex: The page's page index.
    ///   - currentPageIndex: The current page index.
    ///   - totalPageCount: The total number of pages.
    public init(
        page: PageModel,
        pageIndex: Int,
        currentPageIndex: Binding<Int>,
        totalPageCount: Int
    ) {
        self.page = page
        self.pageIndex = pageIndex
        self.currentPageIndexBinding = currentPageIndex
        self.totalPageCount = totalPageCount
    }

    /// The page value.
    public let page: PageModel

    /// The page's page index.
    public let pageIndex: Int

    /// The current page index.
    public var currentPageIndex: Int {
        get { currentPageIndexBinding.wrappedValue }
        set { currentPageIndexBinding.wrappedValue = newValue }
    }

    /// The current page index.
    public let currentPageIndexBinding: Binding<Int>

    /// The total number of pages.
    public let totalPageCount: Int
}

public extension OnboardingFlowPage {

/// Whether this page is the first page.
var isFirstPage: Bool {
    isFirstPage(pageIndex)
}

/// Whether this page is the last page.
var isLastPage: Bool {
    isLastPage(pageIndex)
}

/// Whether this is the current page.
var isCurrentPage: Bool {
    pageIndex == currentPageIndex
}
}
