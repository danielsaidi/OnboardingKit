//
//  TutorialPageTabView.swift
//  Tutti
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

/**
 This view renders tutorial pages in a `TabView` with `page`
 style applied to generate page indicators.

 This view is currently only available on `iOS`.
 */
@available(iOS 14.0, *)
public struct TutorialPageTabView<PageType: TutorialPage, PageViewType: View>: View {

    /**
     Create a tutorial page flow that renders tutorial pages
     in a page control.

     - Parameters:
       - tutorial: The tutorial to present.
       - pageIndex: The current page.
       - style: The style to apply, by default ``TutorialPageTabViewStyle/standard``.
       - pageView: A function that is used to build a view for each page.
     */
    public init(
        tutorial: Tutorial<PageType>,
        pageIndex: Binding<Int>,
        style: TutorialPageTabViewStyle = .standard,
        @ViewBuilder pageView: @escaping PageViewBuilder
    ) {
        self.tutorial = tutorial
        self.pageIndex = pageIndex
        self.pageView = pageView
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(style.currentPageIndicatorTintColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(style.pageIndicatorTintColor)
    }

    public typealias PageViewBuilder = (PageType, _ index: Int) -> PageViewType

    private let pageIndex: Binding<Int>
    private let tutorial: Tutorial<PageType>
    private let pageView: PageViewBuilder

    public var body: some View {
        TabView(selection: pageIndex) {
            ForEach(Array(tutorial.pages.enumerated()), id: \.offset) {
                pageView($0.element, $0.offset)
                    .tag($0.offset)
            }
        }
        .tabViewStyle(.page)
    }
}

@available(iOS 15.0, *)
struct TutorialPageTabView_Previews: PreviewProvider {

    struct Preview: View {

        @State
        private var currentPageIndex = 0

        let background = Color.gray.opacity(0.4)

        let tutorial = Tutorial(pages: [
            tutorialPage(index: 1),
            tutorialPage(index: 2),
            tutorialPage(index: 3),
            tutorialPage(index: 4),
            tutorialPage(index: 5)
        ])

        var body: some View {
            TutorialPageTabView(
                tutorial: tutorial,
                pageIndex: $currentPageIndex
            ) { page, index in
                VStack(spacing: 25) {
                    AsyncImage(url: URL(string: page.imageName ?? ""))
                        .cornerRadius(10)
                        .frame(height: 300)
                        .shadow(color: .gray, radius: 5, x: 0, y: 3)
                        .scaleEffect(currentPageIndex == index ? 1 : 0.9)
                        .animation(.default, value: currentPageIndex)
                    Text(page.title)
                        .font(.title)
                        .padding(.top, 30)
                    Text(page.text)
                    Button("Next", action: goNext)
                        .buttonStyle(.bordered)
                        .disabled(!canGoNext)
                }
                .padding()
                .multilineTextAlignment(.center)
            }
            .background(background.edgesIgnoringSafeArea(.all))
        }

        var canGoNext: Bool {
            currentPageIndex < (tutorial.pages.count - 1)
        }

        func goNext() {
            guard canGoNext else { return }
            withAnimation {
                currentPageIndex += 1
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
