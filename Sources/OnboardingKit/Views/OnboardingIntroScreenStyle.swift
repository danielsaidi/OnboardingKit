//
//  OnboardingIntroScreenStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-21.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used with ``OnboardingIntroScreen``.
///
/// This style can be applied with``SwiftUICore/View/onboardingIntroScreenStyle(_:)`.
public struct OnboardingIntroScreenStyle {

    public init(
        iconSize: Double = 100,
        uspListPadding: Double = 0,
        uspListPresentationDuration: Double = 0.5,
        uspListPresentationDelay: Double = 0.2,
        uspListSpacing: Double = 30
    ) {
        self.iconSize = iconSize
        self.uspListPadding = uspListPadding
        self.uspListPresentationDuration = uspListPresentationDuration
        self.uspListPresentationDelay = uspListPresentationDelay
        self.uspListSpacing = uspListSpacing
    }

    public let iconSize: Double
    public let uspListPadding: Double
    public let uspListPresentationDuration: Double
    public let uspListPresentationDelay: Double
    public let uspListSpacing: Double
}

public extension OnboardingIntroScreenStyle {

    /// The standard intro screen style.
    static var standard: Self { .init() }
}

public extension EnvironmentValues {

    @Entry var onboardingIntroScreenStyle = OnboardingIntroScreenStyle()
}

public extension View {

    func onboardingIntroScreenStyle(
        _ style: OnboardingIntroScreenStyle
    ) -> some View {
        self.environment(\.onboardingIntroScreenStyle, style)
    }
}
