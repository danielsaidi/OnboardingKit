//
//  OnboardingPageViewStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style ``OnboardingPageView``.
///
/// You can apply the style with a view modifier:
///
/// ```swift
/// OnboardingPageView(...)
///     .onboardingPageViewStyle(...)
/// ```
public struct OnboardingPageViewStyle {

    /// Create an onboarding page view style.
    ///
    /// - Parameters:
    ///   - pageIndicatorTintColor: The page indicator color to use, by default `.primary` with opacity.
    ///   - currentPageIndicatorTintColor: The color of the current page indicator, by default `.primary`.
    public init(
        pageIndicatorTintColor: Color = .primary.opacity(0.3),
        currentPageIndicatorTintColor: Color = .primary
    ) {
        self.pageIndicatorTintColor = pageIndicatorTintColor
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
    }

    /// The page indicator color to use.
    public var pageIndicatorTintColor: Color

    /// The color of the current page indicator.
    public var currentPageIndicatorTintColor: Color
}

public extension OnboardingPageViewStyle {

    /// The standard onboarding page view style.
    static var standard: Self {
        .init()
    }
}

public extension View {

    /// Apply a page view style to the view hierarchy.
    func onboardingPageViewStyle(
        _ style: OnboardingPageViewStyle
    ) -> some View {
        self.environment(\.onboardingPageViewStyle, style)
    }
}

private extension OnboardingPageViewStyle {

    struct Key: EnvironmentKey {

        static var defaultValue: OnboardingPageViewStyle { .standard }
    }
}

public extension EnvironmentValues {

    var onboardingPageViewStyle: OnboardingPageViewStyle {
        get { self [OnboardingPageViewStyle.Key.self] }
        set { self [OnboardingPageViewStyle.Key.self] = newValue }
    }
}
