//
//  OnboardingVerticalProgressListStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-22.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style an ``OnboardingVerticalProgressList`.
///
/// This style can be applied with``SwiftUICore/View/onboardingVerticalProgressListStyle(_:)`.
public struct OnboardingVerticalProgressListStyle {

    public init(
        stepSpacing: Double = 20,
        circleSize: Double = 25,
        circleTextSpacing: Double = 20,
        circleColor: Color = .primary,
        circleActiveColor: Color = .blue,
        titleColor: Color = .primary,
        titleActiveColor: Color = .blue,
        lineWidth: Double = 5
    ) {
        self.stepSpacing = stepSpacing
        self.circleSize = circleSize
        self.circleTextSpacing = circleTextSpacing
        self.circleColor = circleColor
        self.circleActiveColor = circleActiveColor
        self.lineWidth = lineWidth
        self.titleColor = titleColor
        self.titleActiveColor = titleActiveColor
    }

    public let stepSpacing: Double
    public let circleSize: Double
    public let circleTextSpacing: Double
    public let circleColor: Color
    public let circleActiveColor: Color
    public let lineWidth: Double
    public let titleColor: Color
    public let titleActiveColor: Color
}

public extension OnboardingVerticalProgressListStyle {

    /// The standard intro screen style.
    static var standard: Self { .init() }
}

public extension EnvironmentValues {

    @Entry var onboardingVerticalProgressListStyle = OnboardingVerticalProgressListStyle()
}

public extension View {

    func onboardingVerticalProgressListStyle(
        _ style: OnboardingVerticalProgressListStyle
    ) -> some View {
        self.environment(\.onboardingVerticalProgressListStyle, style)
    }
}
