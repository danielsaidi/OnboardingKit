//
//  OnboardingFlowState.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-05-22.
//

import SwiftUI

/// This type can be used as page state for a specific onboarding.
///
/// Instead of creating pages and bindings separately, this state manages both.
@Observable
public class OnboardingFlowState<PageModel>: OnboardingFlow.PageInfoProvider {

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
    public var currentPageIndex: Int = 0
}

public extension OnboardingFlowState {

    /// The current page.
    var currentPage: PageModel {
        pages[currentPageIndex]
    }

    /// The total number of pages.
    var totalPageCount: Int {
        pages.count
    }

    /// Try to show the previous page, if one exists.
    func showPreviousPage() {
        guard !isCurrentPageFirst else { return }
        currentPageIndex -= 1
    }

    /// Try to show the next page, if one exists.
    ///
    /// This function will call the provided `action` if the current page is last.
    func showNextPage(
        else action: () -> Void = {}
    ) {
        guard !isCurrentPageLast else { return action() }
        currentPageIndex += 1
    }

    /// Try to show the next page, if one exists.
  ///
  /// /// This function will call the provided `dismiss` if the current page is last.
    @MainActor
    func showNextPage(
        orDismiss dismiss: DismissAction
    ) {
        if isCurrentPageLast { return dismiss.callAsFunction() }
        showNextPage()
    }
}
