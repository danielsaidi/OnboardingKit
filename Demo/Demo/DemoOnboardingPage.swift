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

    let pageInfo: OnboardingPage<DemoOnboardingPage>

    var steps: [OnboardingVerticalProgressListStep] {
        DemoOnboardingPage.allCases.map {
            .init(
                title: .init(stringLiteral: $0.title),
                text: .init(stringLiteral: $0.text)
            )
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            Text(pageInfo.page.title)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .leading)
            OnboardingVerticalProgressList(
                steps: steps,
                stepIndex: pageInfo.currentPageIndex
            )
            Spacer()
        }
        .padding()
    }
}

#Preview {

    struct Preview: View {

        @State var state = OnboardingFlowState(
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
