//
//  PreviewBackground.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct PreviewBackground: View {

    let index: Int

    var body: some View {
        LinearGradient(
            colors: [
                backgroundColor(for: index).opacity(0.8),
                backgroundColor(for: index)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .animation(.default, value: index)
        .ignoresSafeArea()
    }

    func backgroundColor(
        for index: Int
    ) -> Color {
        switch index {
        case 0: .red
        case 1: .green
        case 2: .blue
        default: .gray
        }
    }
}

#Preview {
    PreviewBackground(index: 0)
}
