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
/// custom page view implementation on other platforms.
///
/// Apply an ``SwiftUI/View/onboardingPageViewStyle(_:)`` to
/// your view to customize its style.
public struct OnboardingPageView<Page, PageItemView: View>: View {

    /// Create a tutorial page view.
    ///
    /// - Parameters:
    ///   - pages: The pages to present.
    ///   - pageIndex: The current page.
    ///   - pageView: A page builder function.
    public init(
        pages: [Page],
        pageIndex: Binding<Int>,
        @ViewBuilder pageView: @escaping PageViewBuilder
    ) {
        self.pages = pages
        self.pageIndex = pageIndex
        self.pageView = pageView
    }

    public typealias PageViewBuilder = (OnboardingPageInfo<Page>) -> PageItemView

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
                    .init(
                        page: $0.element,
                        pageIndex: $0.offset,
                        currentPageIndex: pageIndex.wrappedValue,
                        totalPageCount: pages.count
                    )
                )
                .tag($0.offset)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        #else
        PageView(
            pages: Array(pages.enumerated()),
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
    
        var body: some View {
            OnboardingPageView(
                pages: Array(1...5),
                pageIndex: $index
            ) { info in
                VStack(spacing: 20) {
                    Text("Page \(info.page)/\(info.totalPageCount)")
                    Button(info.isLastPage ? "Done" : "Next") {
                        withAnimation {
                            if info.isLastPage {
                                print("Done")
                            } else {
                                index += 1
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .onboardingPageViewStyle(
                .init(
                    pageIndicatorTintColor: .red,
                    currentPageIndicatorTintColor: .gray
                )
            )
            .background(
                LinearGradient(colors: [
                    Color.blue.opacity(0.5),
                    Color.blue
                ], startPoint: .top, endPoint: .bottom)
            )
        }
    }
    
    return Preview()
}
