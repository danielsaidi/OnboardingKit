//
//  DemoOnboardingPageContent.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import SwiftUI

enum DemoOnboardingPage: Int, CaseIterable, Identifiable {

    case step1, step2, step3, step4

    var id: Int { rawValue }
    var pageIndex: Int { rawValue }
    var pageNumber: Int { pageIndex+1 }
    var icon: Image { Image(systemName: "\(pageNumber).circle.fill") }
    var title: String { "Step \(pageNumber)" }

    var text: String {
        switch self {
        case .step1: "The first step is the hardest. 😫"
        case .step2: "The second step is a bit easier. 😅"
        case .step3: "The third step is a victory! 🤩"
        case .step4: "You did it! 🥳"
        }
    }

    var accentColor: Color {
        switch self {
        case .step1: .red
        case .step2: .orange
        case .step3: .yellow
        case .step4: .green
        }
    }
}

struct DemoOnboardingPageContent: View {

    let pageInfo: OnboardingPageInfo<DemoOnboardingPage>

    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            Text(pageInfo.page.title)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 0) {
                ForEach(DemoOnboardingPage.allCases) {
                    listItem(for: $0)
                }
            }
            Spacer()
        }
        .padding()
    }
}

private extension DemoOnboardingPageContent {

    @ViewBuilder
    func listItem(
        for page: DemoOnboardingPage
    ) -> some View {
        let activeColor = pageInfo.page.accentColor
        let inactiveColor = Color.gray
        let isLast = page.pageIndex == pageInfo.totalPageCount - 1
        let isActive = page.pageIndex <= pageInfo.currentPageIndex
        let foregroundColor = isActive ? activeColor : inactiveColor
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                if !isLast {
                    Rectangle()
                        .frame(width: 5, height: 60)
                }
                page.icon
                    .font(.largeTitle)
                    .symbolRenderingMode(.multicolor)
                    .padding(.top, -5)
            }
            .foregroundStyle(foregroundColor)
            VStack(alignment: .leading) {
                Text(page.title)
                    .font(.body.bold())
                Text(page.text)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {

    struct Preview: View {

        @StateObject var state = OnboardingPageState(
            pages: DemoOnboardingPage.allCases
        )

        var body: some View {
            VStack {
                DemoOnboardingPageContent(
                    pageInfo: .init(
                        page: state.pages[state.currentPageIndex],
                        pageIndex: state.currentPageIndex,
                        currentPageIndex: $state.currentPageIndex,
                        totalPageCount: state.totalPageCount
                    )
                )
                Spacer()
            }
            .safeAreaInset(edge: .bottom) {
                OnboardingPrimaryButton("Next") {
                    withAnimation {
                        state.showNextPage()
                    }
                }
                .disabled(state.isCurrentPageLast)
                .padding()
            }
        }
    }

    return Preview()
}
