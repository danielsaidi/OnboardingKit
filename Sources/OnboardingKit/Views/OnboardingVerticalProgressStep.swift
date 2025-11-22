//
//  OnboardingVerticalProgressStep.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-22.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This model represents a step in a vertical progress list.
public struct OnboardingVerticalProgressStep {

    public init(
        title: LocalizedStringKey,
        text: LocalizedStringKey
    ) {
        self.title = title
        self.text = text
    }

    public let title: LocalizedStringKey
    public let text: LocalizedStringKey
}
