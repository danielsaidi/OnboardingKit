//
//  TutorialSlideViewStyle.swift
//  Tutti
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be used to style ``TutorialSlideView`` views
 with custom colors.
 */
@available(iOS 13.0, *)
public struct TutorialSlideViewStyle {

    /**
     Create a tutorial slide view style.

     - Parameters:
       - pageIndicatorTintColor: The page indicator color to use.
       - currentPageIndicatorTintColor: The color of the current page indicator.
     */
    public init(
        pageIndicatorTintColor: Color,
        currentPageIndicatorTintColor: Color
    ) {
        self.pageIndicatorTintColor = pageIndicatorTintColor
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
    }

    /// The page indicator color to use.
    public var pageIndicatorTintColor: Color

    /// The color of the current page indicator.
    public var currentPageIndicatorTintColor: Color
}

@available(iOS 13.0, *)
public extension TutorialSlideViewStyle {

    /**
     This standard style applies a primary tint color to the
     indicators, with less opacity to non-current indicators.
     */
    static var standard = TutorialSlideViewStyle(
        pageIndicatorTintColor: .primary.opacity(0.3),
        currentPageIndicatorTintColor: .primary)
}
