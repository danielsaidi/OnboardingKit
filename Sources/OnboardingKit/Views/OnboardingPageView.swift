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

/// This view can be used to show a collection of pages that
/// can be swiped through horizontally.
///
/// This view uses a regular SwiftUI `TabView` on iOS, and a
/// custom, internal `PageView` implementation for all other
/// platforms where the paged tab view style isn't available.
///
/// You can apply ``SwiftUI/View/onboardingPageViewStyle(_:)``
/// to customize the visual style of an onboarding page view,
/// regardless of which underlying implementation is uses.
public struct OnboardingPageView<Page, Content: View>: View {

    /// Create a tutorial page view.
    ///
    /// - Parameters:
    ///   - pages: The pages to present.
    ///   - pageIndex: The current page index.
    ///   - content: A page content builder function.
    public init(
        pages: [Page],
        pageIndex: Binding<Int>,
        @ViewBuilder content: @escaping ContentBuilder
    ) {
        self.pages = pages
        self._pageIndex = pageIndex
        self.content = content
    }

    public typealias PageInfo = OnboardingPageInfo<Page>
    public typealias ContentBuilder = (PageInfo) -> Content

    private let pages: [Page]
    private let content: ContentBuilder

    @Binding
    private var pageIndex: Int

    @Environment(\.onboardingPageViewStyle)
    private var style

    public var body: some View {
        bodyContent
            .onAppear { setupAppearance() }
    }
}

private extension OnboardingPageView {

    var bodyContent: some View {
        #if os(iOS) || os(visionOS)
        TabView(selection: $pageIndex) {
            ForEach(
                Array(pages.enumerated()),
                id: \.offset,
                content: content
            )
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        #else
        PageView(
            pages: Array(pages.enumerated()),
            currentPageIndex: $pageIndex,
            pageIndicatorDisplayMode: .always,
            pageIndicatorStyle: .init(
                dotColor: style.pageIndicatorTintColor,
                currentDotColor: style.currentPageIndicatorTintColor
            ),
            pageBuilder: content
        )
        #endif
    }

    func content(
        for info: EnumeratedSequence<[Page]>.Element
    ) -> some View {
        content(
            .init(
                page: info.element,
                pageIndex: info.offset,
                currentPageIndex: pageIndex,
                totalPageCount: pages.count
            )
        )
        .tag(info.offset)
    }

    @MainActor
    func setupAppearance() {
        #if os(iOS)
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor(style.pageIndicatorTintColor)
        appearance.currentPageIndicatorTintColor = UIColor(style.currentPageIndicatorTintColor)
        #endif
    }
}

#Preview {
    
    struct Preview: View {
        
        @State
        private var index = 0

        var pages = Array(1...3)

        var body: some View {
            OnboardingPageView(
                pages: pages,
                pageIndex: $index
            ) {
                PreviewPage(index: $index, info: $0)
                    .padding(.bottom, 50)
            }
            .onboardingPageViewStyle(
                .init(
                    pageIndicatorTintColor: .yellow.opacity(0.5),
                    currentPageIndicatorTintColor: .yellow
                )
            )
            .background(
                PreviewBackground(index: index)
            )
        }
    }
    
    return Preview()
}
