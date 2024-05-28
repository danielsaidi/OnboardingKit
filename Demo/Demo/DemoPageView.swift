//
//  DemoPageView.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-03-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import SwiftUI

struct DemoPageView: View {
    
    let onboarding: LocalizedOnboardingFlow

    @Binding var index: Int
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        OnboardingPageView(
            pages: onboarding.pages,
            pageIndex: $index
        ) { page, info in
            DemoPage(page: page, info: info) {
                Button(info.isLastPage ? "Done" : "Next") {
                    if info.isLastPage { return dismiss() }
                    withAnimation {
                        index += 1
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .ignoresSafeArea()
        .onDisappear { index = 0 }
        .onboardingPageViewStyle(
            .init(
                pageIndicatorTintColor: .white.opacity(0.5),
                currentPageIndicatorTintColor: .white
            )
        )
    }
}

#Preview {

    DemoPageView(
        onboarding: .demo,
        index: .constant(0)
    )
}
