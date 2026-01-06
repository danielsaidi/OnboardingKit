//
//  PreviewBackground.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct PreviewBackground: View {

    let index: Int

    var body: some View {
        LinearGradient(
            colors: [
                color(at: index).opacity(0.8),
                color(at: index)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .animation(.default, value: index)
        .ignoresSafeArea()
    }
}

private extension PreviewBackground {

    func color(at index: Int) -> Color {
        switch index {
        case 0: .red
        case 1: .green
        case 2: .blue
        default: .yellow
        }
    }
}

#Preview {
    PreviewBackground(index: 0)
}
