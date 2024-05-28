//
//  DemoPageBackground.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import SwiftUI

struct DemoPageBackground: View {

    let index: Int

    var body: some View {
        LinearGradient(
            colors: [
                pageColor(at: index).opacity(0.8),
                pageColor(at: index),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        .animation(.default, value: index)
    }
}

extension DemoPageBackground {

    func pageColor(at index: Int) -> Color {
        switch index {
        case 0: .red
        case 1: .green
        case 2: .blue
        default: .yellow
        }
    }
}

#Preview {
    DemoPageBackground(index: 0)
}
