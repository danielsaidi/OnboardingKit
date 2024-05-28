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
            image
            Text(info.page.title)
                .font(.title)
            Text(info.page.text)
        }
        .padding(30)
        .frame(maxWidth: .infinity)
        .background()
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 1, y: 1)
        .frame(maxHeight: .infinity)
        .multilineTextAlignment(.center)
        .scaleEffect(info.isCurrentPage ? 1 : 0.5)
        .animation(.bouncy, value: index)
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

private extension DemoPageContent {

    var image: some View {
        Image(systemName: "\(info.pageIndex).circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 150)
            .padding(.bottom, 20)
    }
}

#Preview {

    struct Preview: View {

        @State
        private var index = 0

        var body: some View {
            ZStack {
                Color.red.ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { index += 1 }
                    }

                DemoPageContent(
                    index: $index,
                    info: .init(
                        page: .init(
                            title: "Foo",
                            text: "Bar",
                            imageName: "onboarding.demo-flow.0.image"
                        ),
                        pageIndex: 1,
                        currentPageIndex: index,
                        totalPageCount: 2
                    )
                )
            }
        }
    }

    return Preview()
}
