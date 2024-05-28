//
//  DemoPageContent.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import SwiftUI

struct DemoPageContent: View {

    @Binding
    var index: Int
    let info: OnboardingPageInfo<LocalizedOnboardingFlow.Page>

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "\(info.pageIndex).circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 150)
                .shadow(radius: 1, y: 1)
                .padding()
                .scaleEffect(info.isCurrentPage ? 1 : 0.5)
                .animation(.bouncy, value: index)
            Text(info.page.title)
                .font(.title)
            Text(info.page.text)
        }
        .frame(maxHeight: .infinity)
        .multilineTextAlignment(.center)
        .padding()
        .safeAreaInset(edge: .bottom) {
            Button(info.isLastPage ? "Done" : "Next") {
                if info.isLastPage { return dismiss() }
                withAnimation {
                    index += 1
                }
            }
            .buttonStyle(.borderedProminent)
            .shadow(radius: 1, y: 1)
            .padding()
        }
    }
}

#Preview {

    struct Preview: View {

        @State
        private var index = 0

        var body: some View {
            DemoPageContent(
                index: $index,
                info: .init(
                    page: .init(
                        title: "Foo",
                        text: "Bar",
                        imageName: "onboarding.demo-flow.0.image"
                    ),
                    pageIndex: 0,
                    currentPageIndex: 1,
                    totalPageCount: 2
                )
            )
        }
    }

    return Preview()
}
