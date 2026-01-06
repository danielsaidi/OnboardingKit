//
//  OnboardingUspListStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-21.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style an ``OnboardingUspList``.
///
/// This style can be applied with``SwiftUICore/View/onboardingUspListStyle(_:)`.
public struct OnboardingUspListStyle {

    public init(
        padding: Double = 0,
        itemSpacing: Double = 30,
        itemPresentationDuration: Double = 0.5,
        itemPresentationDelay: Double = 0.2
    ) {
        self.padding = padding
        self.itemSpacing = itemSpacing
        self.itemPresentationDuration = itemPresentationDuration
        self.itemPresentationDelay = itemPresentationDelay
    }

    public let padding: Double
    public let itemSpacing: Double
    public let itemPresentationDuration: Double
    public let itemPresentationDelay: Double
}

public extension OnboardingUspListStyle {

    /// The standard intro screen style.
    static var standard: Self { .init() }
}

public extension EnvironmentValues {

    @Entry var onboardingUspListStyle = OnboardingUspListStyle()
}

public extension View {

    func onboardingUspListStyle(
        _ style: OnboardingUspListStyle
    ) -> some View {
        self.environment(\.onboardingUspListStyle, style)
    }
}
