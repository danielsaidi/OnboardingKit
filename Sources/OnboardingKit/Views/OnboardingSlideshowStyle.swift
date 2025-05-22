//
//  OnboardingSlideshowStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can style ``OnboardingSlideshow`` views.
///
/// Use the ``SwiftUICore/View/onboardingSlideshowStyle(_:)``
/// view modifier to apply this style.
public struct OnboardingSlideshowStyle {

    /// Create an onboarding slideshow style.
    ///
    /// - Parameters:
    ///   - progressBarBackgroundColor: The color to use below the progress bar, by default `.primary` with `0.2` opacity.
    ///   - progressBarForegroundColor: The color to use for the progress bar, by default `.primary`.
    ///   - progressBarHeight: The height of the progress bar, by default `3.0`.
    public init(
        progressBarBackgroundColor: Color? = nil,
        progressBarForegroundColor: Color? = nil,
        progressBarHeight: Double? = nil
    ) {
        self.progressBarBackgroundColor = progressBarBackgroundColor ?? .primary.opacity(0.2)
        self.progressBarForegroundColor = progressBarForegroundColor ?? .primary
        self.progressBarHeight = progressBarHeight ?? 3.0
    }

    /// The color to use below the progress bar.
    public var progressBarBackgroundColor: Color

    /// The color to use for the progress bar.
    public var progressBarForegroundColor: Color

    /// The height of the progress bar.
    public var progressBarHeight: Double
}

public extension OnboardingSlideshowStyle {

    /// The standard onboarding slideshow style.
    static var standard: Self {
        .init()
    }
}

public extension View {

    /// Apply a slideshow style to the view hierarchy.
    func onboardingSlideshowStyle(
        _ value: OnboardingSlideshowStyle
    ) -> some View {
        self.environment(\.onboardingSlideshowStyle, value)
    }
}

public extension EnvironmentValues {
    
    @Entry var onboardingSlideshowStyle = OnboardingSlideshowStyle.standard
}
