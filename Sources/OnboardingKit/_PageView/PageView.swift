//
//  PageView_macOS.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2022-03-30.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import Combine

/// This view wraps its page views in a `ScrollView` that applies overlays and
/// gestures to mimic a `.page`-styled `TabView`.
///
/// The view supports arrow and edge tap navigation. You can set it up with a set
/// of `pages`, or with a set of `items` and a page view builder.
struct PageView<PageViewType: View>: View {
    
    /// Create a page view with a list of page views.
    init(
        pages: [PageViewType],
        currentPageIndex: Binding<Int>,
        pageIndicatorDisplayMode: PageIndicator.DisplayMode = .automatic,
        pageIndicatorStyle: PageIndicatorStyle = .standard
    ) {
        self.currentPageIndex = currentPageIndex
        self.pages = pages
        self.pageIndicatorDisplayMode = pageIndicatorDisplayMode
        self.pageIndicatorStyle = pageIndicatorStyle
    }

    /// Create a page view with a list of values, and a page
    /// view builder that is called for each value.
    init<Model>(
        pages: [Model],
        currentPageIndex: Binding<Int>,
        pageIndicatorDisplayMode: PageIndicator.DisplayMode = .automatic,
        pageIndicatorStyle: PageIndicatorStyle = .standard,
        @ViewBuilder pageBuilder: (Model) -> PageViewType
    ) {
        self.currentPageIndex = currentPageIndex
        self.pages = pages.map(pageBuilder)
        self.pageIndicatorDisplayMode = pageIndicatorDisplayMode
        self.pageIndicatorStyle = pageIndicatorStyle
    }

    private var currentPageIndex: Binding<Int>
    private let pageIndicatorDisplayMode: PageIndicator.DisplayMode
    private let pageIndicatorStyle: PageIndicatorStyle
    private var pages: [PageViewType]

    @Environment(\.layoutDirection) var layoutDirection

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                ScrollViewReader { scroll in
                    ScrollView(.horizontal) {
                        pageStack(for: geo)
                    }
                    .prefersScrollAdjustments(
                        for: scroll,
                        layoutDirection: layoutDirection,
                        showPrevious: { showPreviousPage() },
                        showNext: { showNextPage() }
                    )
                    .onReceive(Just(currentPageIndex)) { index in
                        withAnimation {
                            scroll.scrollTo(index.wrappedValue)
                        }
                    }
                    .overlay(bugfixLayer(for: scroll))
                }
                pageIndicator
            }
        }
    }
}

private extension View {

    @ViewBuilder
    func prefersScrollAdjustments(
        for scroll: ScrollViewProxy,
        layoutDirection: LayoutDirection,
        showPrevious: @escaping () -> Void,
        showNext: @escaping () -> Void
    ) -> some View {
        #if os(iOS) || os(watchOS) || os(visionOS)
        if #available(iOS 16.0, watchOS 9.0, *) {
            self.scrollDisabled(true)
        } else {
            self
        }
        #else
        if #available(macOS 13.0, tvOS 16.0, *) {
            self.scrollDisabled(true)
                .onMoveCommand { direction in
                    switch direction.adjusted(for: layoutDirection) {
                    case .left: showPrevious()
                    case .right: showNext()
                    default: break
                    }
                }
        } else {
            self
        }
        #endif
    }
}

#if os(macOS) || os(tvOS)
private extension MoveCommandDirection {

    func adjusted(
        for direction: LayoutDirection
    ) -> Self {
        switch self {
        case .left: direction == .leftToRight ? .left : .right
        case .right: direction == .leftToRight ? .right : .left
        default: self
        }
    }
}
#endif

private extension PageView {

    @ViewBuilder
    var pageIndicator: some View {
        if shouldShowPageIndicator {
            PageIndicator(
                numberOfPages: pages.count,
                currentPageIndex: currentPageIndex,
                style: pageIndicatorStyle
            ).padding()
        } else {
            EmptyView()
        }
    }

    // This is needed for the scroll view transition to play.
    func bugfixLayer(for scroll: ScrollViewProxy) -> some View {
        Text("\(currentPageIndex.wrappedValue)")
            .opacity(0)
    }

    func pageStack(
        for geo: GeometryProxy
    ) -> some View {
        HStack {
            ForEach(Array(pages.enumerated()), id: \.offset) {
                $0.element
                    .id($0.offset)
                    .tag($0.offset)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(gestureLayer)
            }
        }
    }
    
    var gestureLayer: some View {
        #if os(tvOS)
        EmptyView()
        #else
        HStack(spacing: 0) {
            gestureLayerView(onTap: showPreviousPage)
            gestureLayerView(onTap: showNextPage)
        }
        #endif
    }

    #if !os(tvOS)
    func gestureLayerView(
        onTap: @escaping () -> Void
    ) -> some View {
        Color.white.opacity(0.00001)
            .onSwipeGesture(
                left: { showNextPage() },
                right: { showPreviousPage() }
            )
            .simultaneousGesture(
                TapGesture().onEnded(onTap)
            )
    }
    #endif
}

private extension PageView {
    
    var shouldShowPageIndicator: Bool {
        switch pageIndicatorDisplayMode {
        case .always: return true
        case .automatic: return pages.count > 1
        case .never: return false
        }
    }

    func setPageIndex(to index: Int) {
        currentPageIndex.wrappedValue = index
    }
    
    func showNextPage() {
        guard currentPageIndex.wrappedValue < pages.count - 1 else { return }
        setPageIndex(to: currentPageIndex.wrappedValue + 1)
    }
    
    func showPreviousPage() {
        guard currentPageIndex.wrappedValue > 0 else { return }
        setPageIndex(to: currentPageIndex.wrappedValue - 1)
    }
}

#Preview {

    struct Preview: View {

        @State var pageIndex = 0

        var body: some View {
            PageView(
                pages: Array(1...10),
                currentPageIndex: $pageIndex
            ) { page in
                VStack {
                    Text("\(page)")
                    HStack {
                        Button("Next") { pageIndex += 1 }
                    }
                }
            }
        }
    }

    return Preview()
}
