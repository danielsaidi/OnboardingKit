//
//  OnboardingSlideshowStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style ``OnboardingSlideshow``.
public struct OnboardingSlideshowStyle {

    /// Create an onboarding slideshow style.
    ///
    /// - Parameters:
    ///   - progressBarBackgroundColor: The color to use below the progress bar, by default `.primary` with opacity.
    ///   - progressBarForegroundColor: The color to use for the progress bar, by default `.primary`.
    ///   - progressBarHeight: The height of the progress bar, by default `3.0`.
    public init(
        progressBarBackgroundColor: Color = .primary.opacity(0.2),
        progressBarForegroundColor: Color = .primary,
        progressBarHeight: Double = 3.0
    ) {
        self.progressBarBackgroundColor = progressBarBackgroundColor
        self.progressBarForegroundColor = progressBarForegroundColor
        self.progressBarHeight = progressBarHeight
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
        _ style: OnboardingSlideshowStyle
    ) -> some View {
        self.environment(\.onboardingSlideshowStyle, style)
    }
}

private extension OnboardingSlideshowStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: OnboardingSlideshowStyle { .standard }
    }
}

public extension EnvironmentValues {

    var onboardingSlideshowStyle: OnboardingSlideshowStyle {
        get { self [OnboardingSlideshowStyle.Key.self] }
        set { self [OnboardingSlideshowStyle.Key.self] = newValue }
    }
}
