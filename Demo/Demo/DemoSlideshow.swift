//
//  DemoSlideshow.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import SwiftUI

struct DemoSlideshow: View {

    let onboarding: LocalizedOnboarding

    @Binding var index: Int

    var body: some View {
        OnboardingSlideshow(
            pages: onboarding.pages,
            pageIndex: $index,
            config: .init(slideDuration: 3),
            onStoryCompleted: { print("Completed!") },
            background: { _ in DemoPageBackground(index: index) },
            content: { DemoPageContent(index: $index, info: $0) }
        )
    }
}

#Preview {
    
    struct Preview: View {

        @State
        private var index = 0

        var body: some View {
            DemoSlideshow(
                onboarding: .demo,
                index: $index
            )
        }
    }

    return Preview()

}
