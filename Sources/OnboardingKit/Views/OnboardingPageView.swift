//
//  OnboardingPageView.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if os(iOS)
import UIKit
#endif

/**
 This view can be used to render a collection of pages, that
 can be swiped through horizontally.
 
 This will use a regular `TabView` on iOS, and a custom page
 view on other platforms.
 
 Apply the `.onboardingPageViewStyle(...)` modifier to style
 this view.
 */
public struct OnboardingPageView<Page, PageView: View>: View {

    /// Create a tutorial page view.
    ///
    /// - Parameters:
    ///   - pages: The pages to present.
    ///   - pageIndex: The current page.
    ///   - pageView: A function used to build a view for each page.
    public init(
        pages: [Page],
        pageIndex: Binding<Int>,
        @ViewBuilder pageView: @escaping PageViewBuilder
    ) {
        self.pages = pages
        self.pageIndex = pageIndex
        self.pageView = pageView
    }

    public typealias PageViewBuilder = (Page, OnboardingPageInfo) -> PageView

    private let pageIndex: Binding<Int>
    private let pages: [Page]
    private let pageView: PageViewBuilder
    
    @Environment(\.onboardingPageViewStyle)
    private var style

    public var body: some View {
        bodyContent
            .task { setupAppearance() }
    }
}

private extension OnboardingPageView {
    
    var bodyContent: some View {
        #if os(iOS)
        TabView(selection: pageIndex) {
            ForEach(Array(pages.enumerated()), id: \.offset) {
                pageView(
                    $0.element,
                    .init(
                        pageIndex: $0.offset,
                        currentPageIndex: pageIndex.wrappedValue,
                        totalPageCount: pages.count
                    )
                )
                .tag($0.offset)
            }
        }
        .tabViewStyle(.page)
        #else
        PageView(
            items: Array(pages.enumerated()),
            currentPageIndex: pageIndex,
            pageIndicatorDisplayMode: .always,
            pageIndicatorStyle: .init(
                dotColor: style.pageIndicatorTintColor,
                currentDotColor: style.currentPageIndicatorTintColor
            )
        ) {
            pageView(
                $0.element,
                .init(
                    pageIndex: $0.offset,
                    currentPageIndex: pageIndex.wrappedValue,
                    totalPageCount: pages.count
                )
            )
            .tag($0.offset)
        }
        #endif
    }
    
    func setupAppearance() {
        #if os(iOS)
        let appearance = UIPageControl.appearance()
        appearance.currentPageIndicatorTintColor = UIColor(style.currentPageIndicatorTintColor)
        appearance.pageIndicatorTintColor = UIColor(style.pageIndicatorTintColor)
        #endif
    }
}
