//
//  DemoOnboardingScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-05-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import SwiftUI

struct DemoOnboardingScreen: View {

    let type: ScreenType

    enum ScreenType { case pageView, slideshow }

    @Environment(\.dismiss) var dismiss

    @StateObject var state = OnboardingPageState(pages: DemoOnboardingPage.allCases)

    var body: some View {
        OnboardingScreen(
            pages: state.pages,
            pageIndex: $state.currentPageIndex,
            content: {
                switch type {
                case .pageView: pageView
                case .slideshow: slideshow
                }
            },
            buttons: { params in
                OnboardingPrimaryButton(params.isLastPage ? "Done" : "Next") {
                    withAnimation {
                        state.showNextPage(orDismiss: dismiss)
                    }
                }
                .tint(state.currentPage.accentColor)
                .shadow(radius: 1, x: 0, y: 1)
            }
        )
        .background(state.currentPage.accentColor.opacity(0.1))
    }

    var pageView: some View {
        OnboardingPageView(
            pages: state.pages,
            pageIndex: $state.currentPageIndex,
            content: DemoOnboardingPageContent.init
        )
    }

    var slideshow: some View {
        OnboardingSlideshow(
            pages: state.pages,
            pageIndex: $state.currentPageIndex,
            onStoryCompleted: { print("Story complete!") },
            content: {
                DemoOnboardingPageContent(pageInfo: $0)
                    .padding(.top, 40)
            }
        )
    }
}
