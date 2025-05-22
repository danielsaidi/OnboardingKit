//
//  OnboardingPageView.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if os(iOS)
import UIKit
#endif

/// This view can be used to show a collection of pages that
/// can be swiped through horizontally.
///
/// Apply an ``SwiftUI/View/onboardingPageViewStyle(_:)`` to
/// customize the visual style of the page view.
///
/// This view has support for navigating with the arrow keys,
/// as well as with background swipes and edge taps.
public struct OnboardingPageView<PageModel, Page: View>: View {

    /// Create an onboarding page view.
    ///
    /// - Parameters:
    ///   - pages: The pages to present.
    ///   - pageIndex: The current page index.
    ///   - content: A page builder function.
    public init(
        pages: [PageModel],
        pageIndex: Binding<Int>,
        @ViewBuilder content: @escaping PageBuilder
    ) {
        self.pages = pages
        self._pageIndex = pageIndex
        self.content = content
    }

    public typealias PageInfo = OnboardingPageInfo<PageModel>
    public typealias PageBuilder = (PageInfo) -> Page

    private let pages: [PageModel]
    private let content: PageBuilder

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
        for info: EnumeratedSequence<[PageModel]>.Element
    ) -> some View {
        content(
            .init(
                page: info.element,
                pageIndex: info.offset,
                currentPageIndex: $pageIndex,
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

        @StateObject var state = OnboardingPageState(
            pages: Array(0...3)
        )

        var body: some View {
            OnboardingPageView(
                pages: state.pages,
                pageIndex: $state.currentPageIndex,
                content: {
                    PreviewPage(info: $0)
                        .frame(maxHeight: .infinity)
                }
            )
            .onboardingPageViewStyle(
                .init(
                    pageIndicatorTintColor: .blue,
                    currentPageIndicatorTintColor: .yellow
                )
            )
            .background(
                PreviewBackground(
                    index: state.currentPageIndex
                )
            )
            .safeAreaInset(edge: .bottom) {
                OnboardingPrimaryButton("HEJ") {
                    withAnimation {
                        state.showNextPage()
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
    }
    
    return Preview()
}
