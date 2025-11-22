//
//  OnboardingPageViewStyle.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can style ``OnboardingPageView`` views.
///
/// This style can be applied with ``SwiftUICore/View/onboardingPageViewStyle(_:)``.
public struct OnboardingPageViewStyle {

    /// Create an onboarding page view style.
    ///
    /// - Parameters:
    ///   - pageIndicatorTintColor: The page indicator color to use, by default `.primary` with `0.3` opacity.
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

    /// A standard onboarding page view style.
    static var standard: Self { .init() }
}

public extension View {

    /// Apply a page view style environment value.
    func onboardingPageViewStyle(
        _ style: OnboardingPageViewStyle
    ) -> some View {
        self.environment(\.onboardingPageViewStyle, style)
    }
}

public extension EnvironmentValues {

    /// An onboarding page view style value.
    @Entry var onboardingPageViewStyle = OnboardingPageViewStyle.standard
}
