//
//  OnboardingSlideshowStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can style ``OnboardingSlideshow`` views.
///
/// This style can be applied with ``SwiftUICore/View/onboardingSlideshowStyle(_:)``.
public struct OnboardingSlideshowStyle {

    /// Create an onboarding slideshow style.
    ///
    /// - Parameters:
    ///   - progressBarBackgroundColor: The progress bar background, by default transparent `.primary`.
    ///   - progressBarForegroundColor: The progress bar foreground, by default `.primary`.
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

    /// A standard onboarding slideshow style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply an onboarding slideshow style value.
    func onboardingSlideshowStyle(
        _ value: OnboardingSlideshowStyle
    ) -> some View {
        self.environment(\.onboardingSlideshowStyle, value)
    }
}

public extension EnvironmentValues {

    /// An onboarding slideshow style value.
    @Entry var onboardingSlideshowStyle = OnboardingSlideshowStyle.standard
}
