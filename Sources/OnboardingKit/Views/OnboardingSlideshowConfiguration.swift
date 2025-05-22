//
//  OnboardingSlideshowConfiguration.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can configure ``OnboardingSlideshow`` views.
///
/// This type is not applied with a view modifier, since the
/// slideshow timer must be created in the initializer.
public struct OnboardingSlideshowConfiguration {

    /// Create an onboarding slideshow configuration.
    ///
    /// - Parameters:
    ///   - isAnimated: Whether or not the slideshow should animates the slide, by default `true`.
    ///   - slideDuration: The duration of each slide, by default `5`.
    ///   - timeTickIncrement: The duration of each tick, by default `0.05`.
    ///   - nextAccessibilityLabel: The accessibility label for the next button overlay, by default "Next".
    ///   - previousAccessibilityLabel: The accessibility label for the previous button overlay, by default "Previous".
    public init(
        isAnimated: Bool? = nil,
        slideDuration: TimeInterval? = nil,
        timeTickIncrement: TimeInterval? = nil,
        nextAccessibilityLabel: String? = nil,
        previousAccessibilityLabel: String? = nil
    ) {
        self.isAnimated = isAnimated ?? true
        self.slideDuration = slideDuration ?? 5
        self.timerTickIncrement = timeTickIncrement ?? 0.05
        self.nextAccessibilityLabel = nextAccessibilityLabel ?? "Next"
        self.previousAccessibilityLabel = previousAccessibilityLabel ?? "Previous"
    }

    /// Whether or not the slideshow animates the slide transitions.
    public var isAnimated: Bool

    /// The duration of each slide.
    public var slideDuration: TimeInterval

    /// The duration increment per tick.
    public var timerTickIncrement: TimeInterval

    /// The accessibility label for the next button overlay.
    public var nextAccessibilityLabel: String

    /// The accessibility label for the previous button overlay.
    public var previousAccessibilityLabel: String
}

public extension OnboardingSlideshowConfiguration {

    /// A standard onboarding slideshow style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply an onboarding slideshow configuration value.
    func onboardingSlideshowConfiguration(
        _ value: OnboardingSlideshowConfiguration
    ) -> some View {
        self.environment(\.onboardingSlideshowConfiguration, value)
    }
}

public extension EnvironmentValues {

    /// An onboarding slideshow configuration value.
    @Entry var onboardingSlideshowConfiguration = OnboardingSlideshowConfiguration.standard
}
