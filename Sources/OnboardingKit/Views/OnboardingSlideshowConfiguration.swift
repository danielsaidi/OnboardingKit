//
//  OnboardingSlideshowConfiguration.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This struct can be used to config ``OnboardingSlideshow``.
public struct OnboardingSlideshowConfiguration {

    /// Create a slideshow configuration.
    ///
    /// - Parameters:
    ///   - isAnimated: Whether or not the slideshow should animates the slide, by default `true`.
    ///   - slideDuration: The duration of each slide, by default `5`.
    ///   - timeTickIncrement: The duration of each tick, by default `0.05`.
    ///   - nextAccessibilityLabel: The accessibility label for the next button overlay, by default "Next".
    ///   - previousAccessibilityLabel: The accessibility label for the previous button overlay, by default "Previous".
    public init(
        isAnimated: Bool = true,
        slideDuration: TimeInterval = 5,
        timeTickIncrement: TimeInterval = 0.05,
        nextAccessibilityLabel: String = "Next",
        previousAccessibilityLabel: String = "Previous"
    ) {
        self.isAnimated = isAnimated
        self.slideDuration = slideDuration
        self.timerTickIncrement = timeTickIncrement
        self.nextAccessibilityLabel = nextAccessibilityLabel
        self.previousAccessibilityLabel = previousAccessibilityLabel
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

    /// The standard onboarding slideshow style.
    static var standard: Self {
        .init()
    }
}
