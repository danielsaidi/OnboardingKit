//
//  OnboardingUspListItemStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-21.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style an ``OnboardingUspListItem``.
///
/// This style can be applied with``SwiftUICore/View/onboardingUspListItemStyle(_:)`.
public struct OnboardingUspListItemStyle {

    public init(
        iconSize: Double = 45
    ) {
        self.iconSize = iconSize
    }

    public let iconSize: Double
}

public extension OnboardingUspListItemStyle {

    /// The standard intro screen style.
    static var standard: Self { .init() }
}

public extension EnvironmentValues {

    @Entry var onboardingUspListItemStyle = OnboardingUspListItemStyle()
}

public extension View {

    func onboardingUspListItemStyle(
        _ style: OnboardingUspListItemStyle
    ) -> some View {
        self.environment(\.onboardingUspListItemStyle, style)
    }
}
