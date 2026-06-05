//
//  OnboardingFlowState.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-05-22.
//

import SwiftUI

/// This observable class can be used to manage the state of
/// an onboarding flow.
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
    /// This function will try to show the next page, if one
    /// exists, else call the provided `action`.
    func showNextPage(
        else action: () -> Void = {}
    ) {
        guard !isCurrentPageLast else { return action() }
        currentPageIndex += 1
    }

    /// Try to show the next page, if one exists.
    ///
    /// This function will try to show the next page, if one
    /// exists, else call the provided `dismiss` action.
    @MainActor
    func showNextPage(
        orDismiss dismiss: DismissAction
    ) {
        if isCurrentPageLast { return dismiss.callAsFunction() }
        showNextPage()
    }
}
