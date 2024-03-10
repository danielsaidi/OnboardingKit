//
//  TutorialPageView.swift
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
 This view renders a tutorial in a horizontally sliding view.
 */
public struct TutorialPageView<PageType: TutorialPage, PageViewType: View>: View {
    
    /// Create a tutorial page view for a standard tutorial.
    ///
    /// - Parameters:
    ///   - tutorial: The tutorial to present.
    ///   - pageIndex: The current page.
    ///   - style: The style to apply, by default ``TutorialPageViewStyle/standard``.
    ///   - pageView: A function used to build a view for each page.
    public init(
        tutorial: Tutorial,
        pageIndex: Binding<Int>,
        style: TutorialPageViewStyle = .standard,
        @ViewBuilder pageView: @escaping PageViewBuilder
    ) where PageType == TutorialPage {
        self.tutorial = tutorial
        self.pages = tutorial.pages
        self.pageIndex = pageIndex
        self.style = style
        self.pageView = pageView
        setupAppearance()
    }
    
    /// Create a tutorial page view for a generic tutorial.
    ///
    /// This initializer uses a ``GenericTutorial`` that has
    /// a generic page collection that matches the page type
    /// of this view.
    ///
    /// - Parameters:
    ///   - tutorial: The tutorial to present.
    ///   - pageIndex: The current page.
    ///   - style: The style to apply, by default ``TutorialPageViewStyle/standard``.
    ///   - pageView: A function used to build a view for each page.
    public init(
        tutorial: GenericTutorial<PageType>,
        pageIndex: Binding<Int>,
        style: TutorialPageViewStyle = .standard,
        @ViewBuilder pageView: @escaping PageViewBuilder
    ) {
        self.tutorial = tutorial
        self.pages = tutorial.genericPages
        self.pageIndex = pageIndex
        self.style = style
        self.pageView = pageView
        setupAppearance()
    }
    
    func setupAppearance() {
        #if os(iOS)
        let appearance = UIPageControl.appearance()
        appearance.currentPageIndicatorTintColor = UIColor(style.currentPageIndicatorTintColor)
        appearance.pageIndicatorTintColor = UIColor(style.pageIndicatorTintColor)
        #endif
    }

    public typealias PageViewBuilder = (PageType, TutorialPageInfo) -> PageViewType

    private let pageIndex: Binding<Int>
    private let tutorial: Tutorial
    private let pages: [PageType]
    private let pageView: PageViewBuilder
    private let style: TutorialPageViewStyle

    public var body: some View {
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
}

#Preview {

    struct Preview: View {

        @State
        private var pageIndex: Int = 0
        
        @State
        private var animationTrigger = 0

        let background = Color.gray.opacity(0.4)

        let tutorial = Tutorial(pages: [
            tutorialPage(index: 1),
            tutorialPage(index: 2),
            tutorialPage(index: 3),
            tutorialPage(index: 4),
            tutorialPage(index: 5)
        ])

        var body: some View {
            TutorialPageView(
                tutorial: tutorial,
                pageIndex: $pageIndex,
                style: .init(
                    pageIndicatorTintColor: .red,
                    currentPageIndicatorTintColor: .green
                )
            ) { page, info in
                VStack(spacing: 25) {
                    Spacer()
                    #if os(iOS)
                    AsyncImage(url: URL(string: page.imageName ?? ""))
                        .cornerRadius(10)
                        .frame(height: 300)
                        .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
                        .scaleEffect(info.isCurrentPage ? 1 : 0.9)
                    #endif
                    Text(page.title)
                        .font(.title)
                        .padding(.top, 30)
                    Text(page.text)
                    Spacer()
                    Button("Next", action: goNext)
                        .buttonStyle(.bordered)
                        .disabled(info.isLastPage)
                        .padding(60)
                }
                .padding()
                .multilineTextAlignment(.center)
                .scaleEffect(info.isCurrentPage ? 1 : 0.9)
            }
            .onChange(of: pageIndex) { newValue in
                withAnimation {
                    animationTrigger = newValue
                }
            }
        }

        func goNext() {
            withAnimation {
                pageIndex += 1
            }
        }

        static func tutorialPage(index: Int) -> TutorialPage {
            TutorialPage(
                title: "Page \(index)",
                text: "A longer text to show how it behaves when it line breaks.",
                imageName: "https://picsum.photos/200/300")
        }
    }

    return Preview()
}
