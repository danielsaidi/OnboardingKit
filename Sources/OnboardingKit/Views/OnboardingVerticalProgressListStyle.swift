//
//  OnboardingVerticalProgressListStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-22.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style an ``OnboardingVerticalProgressList`.
///
/// This style can be applied with``SwiftUICore/View/onboardingVerticalProgressListStyle(_:)`.
public struct OnboardingVerticalProgressListStyle {

    public init(
        stepSpacing: Double? = nil,
        circleSize: Double? = nil,
        circleLineWidth: Double = 5,
        circleTextSpacing: Double? = nil,
        circleColor: Color? = nil,
        circleActiveColor: Color? = nil,
        titleColor: Color? = nil,
        titleActiveColor: Color? = nil
    ) {
        self.stepSpacing = stepSpacing ?? 20
        self.circleSize = circleSize ?? 25
        self.circleLineWidth = circleLineWidth
        self.circleTextSpacing = circleTextSpacing ?? 20
        self.circleColor = circleColor ?? .primary
        self.circleActiveColor = circleActiveColor ?? .blue
        self.titleColor = titleColor ?? .primary
        self.titleActiveColor = titleActiveColor ?? .blue
    }

    public init(
        stepSpacing: Double? = nil,
        circleSize: Double? = nil,
        circleLineWidth: Double = 5,
        circleTextSpacing: Double? = nil,
        accentColor: Color? = nil,
        activeAccentColor: Color? = nil
    ) {
        self.init(
            stepSpacing: stepSpacing,
            circleSize: circleSize,
            circleLineWidth: circleLineWidth,
            circleTextSpacing: circleTextSpacing,
            circleColor: accentColor,
            circleActiveColor: activeAccentColor,
            titleColor: accentColor,
            titleActiveColor: activeAccentColor
        )
    }

    public let stepSpacing: Double
    public let circleSize: Double
    public let circleLineWidth: Double
    public let circleTextSpacing: Double
    public let circleColor: Color
    public let circleActiveColor: Color
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
