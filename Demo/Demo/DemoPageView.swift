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
        ) { info in
            DemoPageContent(
                index: $index,
                info: info
            )
            .padding(.bottom, 50)
        }
        .background(DemoPageBackground(index: index))
        .onDisappear { index = 0 }
        .onboardingPageViewStyle(
            .init(
                pageIndicatorTintColor: .white.opacity(0.3),
                currentPageIndicatorTintColor: .yellow
            )
        )
    }
}

#Preview {

    struct Preview: View {

        @State
        private var index = 0

        var body: some View {
            DemoPageView(
                onboarding: .demo,
                index: $index
            )
        }
    }

    return Preview()
}
