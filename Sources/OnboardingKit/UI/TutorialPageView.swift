//
//  TutorialPageView.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI
import UIKit

/**
 This view renders tutorial pages in a `TabView` with a page
 style applied, which lets the user swipe through pages.

 This view is currently only available on `iOS`.
 */
@available(iOS 14.0, *)
public struct TutorialPageView<PageType: TutorialPage, PageViewType: View>: View {

    /**
     Create a tutorial page flow that renders tutorial pages
     in a page control.

     - Parameters:
       - tutorial: The tutorial to present.
       - pageIndex: The current page.
       - style: The style to apply, by default ``TutorialPageViewStyle/standard``.
       - pageView: A function used to build a view for each page.
     */
    public init(
        tutorial: Tutorial<PageType>,
        pageIndex: Binding<Int>,
        style: TutorialPageViewStyle = .standard,
        @ViewBuilder pageView: @escaping PageViewBuilder
    ) {
        self.tutorial = tutorial
        self.pageIndex = pageIndex
        self.pageView = pageView
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(style.currentPageIndicatorTintColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(style.pageIndicatorTintColor)
    }

    public typealias PageViewBuilder = (PageType, TutorialPageInfo) -> PageViewType

    private let pageIndex: Binding<Int>
    private let tutorial: Tutorial<PageType>
    private let pageView: PageViewBuilder

    public var body: some View {
        TabView(selection: pageIndex) {
            ForEach(Array(tutorial.pages.enumerated()), id: \.offset) {
                pageView(
                    $0.element,
                    TutorialPageInfo(
                        pageIndex: $0.offset,
                        currentPageIndex: pageIndex.wrappedValue,
                        totalPageCount: tutorial.pages.count)
                ).tag($0.offset)
            }
        }
        .tabViewStyle(.page)
    }
}

@available(iOS 15.0, *)
struct TutorialPageView_Previews: PreviewProvider {

    struct Preview: View {

        @State
        private var pageIndex: Int = 0

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
                pageIndex: $pageIndex
            ) { page, info in
                VStack(spacing: 25) {
                    Spacer()
                    AsyncImage(url: URL(string: page.imageName ?? ""))
                        .cornerRadius(10)
                        .frame(height: 300)
                        .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
                    Text(page.title)
                        .font(.title)
                        .padding(.top, 30)
                    Text(page.text)
                    Spacer()
                    Button("Next", action: goNext)
                        .buttonStyle(.bordered)
                        .disabled(!info.isLastPage)
                        .padding(60)
                }
                .padding()
                .multilineTextAlignment(.center)
                .scaleEffect(info.isCurrentPage ? 1 : 0.9)
                .animation(.default, value: pageIndex)
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

    static var previews: some View {
        Preview()
    }
}
#endif
