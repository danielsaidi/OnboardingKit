//
//  OnboardingPageView.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if !os(iOS) && !os(visionOS)
import PageView
#endif


// MARK: - View

/// This view can be used to show a collection of onboarding pages, with support
/// for navigating with swipes, arrow keys, and edge taps.
///
/// This view can be styled with ``SwiftUICore/View/onboardingPageViewStyle(_:)``.
public struct OnboardingPageView<Model, Page: View>: View {

    /// Create an onboarding page view.
    ///
    /// - Parameters:
    ///   - pages: The pages to present.
    ///   - pageIndex: The current page index.
    ///   - content: A page builder function.
    public init(
        pages: [Model],
        pageIndex: Binding<Int>,
        @ViewBuilder content: @escaping PageBuilder
    ) {
        self.pages = pages
        self._pageIndex = pageIndex
        self.content = content
    }

    public typealias PageInfo = OnboardingPage<Model>
    public typealias PageBuilder = (PageInfo) -> Page

    private let pages: [Model]
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
            pageIndex: $pageIndex,
            pageBuilder: content
        )
        .pageViewIndicatorStyle(.init(
            dotColor: style.pageIndicatorTintColor,
            currentDotColor: style.currentPageIndicatorTintColor
        ))
        .pageViewIndicatorDisplayMode(.always)
        #endif
    }

    func content(
        for info: EnumeratedSequence<[Model]>.Element
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


// MARK: - Style

/// This style can style ``OnboardingPageView`` views.
///
/// This style can be applied with ``SwiftUICore/View/onboardingPageViewStyle(_:)``.
public struct OnboardingPageViewStyle {

    /// Create an onboarding page view style.
    ///
    /// - Parameters:
    ///   - pageIndicatorTintColor: The page indicator color to use, by default `.primary` with `0.3` opacity.
    ///   - currentPageIndicatorTintColor: The color of the current page indicator, by default `.primary`.
    public init(
        pageIndicatorTintColor: Color = .primary.opacity(0.3),
        currentPageIndicatorTintColor: Color = .primary
    ) {
        self.pageIndicatorTintColor = pageIndicatorTintColor
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
    }

    /// The page indicator color to use.
    public var pageIndicatorTintColor: Color

    /// The color of the current page indicator.
    public var currentPageIndicatorTintColor: Color
}

public extension OnboardingPageViewStyle {

    /// A standard onboarding page view style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a page view style environment value.
    func onboardingPageViewStyle(
        _ style: OnboardingPageViewStyle
    ) -> some View {
        self.environment(\.onboardingPageViewStyle, style)
    }
}

public extension EnvironmentValues {

    /// An onboarding page view style value.
    @Entry var onboardingPageViewStyle = OnboardingPageViewStyle.standard
}


// MARK: - Preview

#Preview {
    
    struct Preview: View {

        @State var state = OnboardingFlowState(
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
