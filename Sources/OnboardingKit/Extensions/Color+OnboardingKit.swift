//
//  Color+OnboardingKit.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2026-02-07.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Color {

    static var secondaryOnboarding: Color {
        .primary.opacity(0.6)
    }
}

#Preview {
    HStack {
        Text("Hello")
            .foregroundStyle(Color.secondary)
        Text("Hello")
            .foregroundStyle(Color.secondaryOnboarding)
    }
    .font(.largeTitle)
}
