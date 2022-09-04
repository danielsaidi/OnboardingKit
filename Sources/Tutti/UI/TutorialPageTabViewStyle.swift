//
//  TutorialPageTabViewStyle.swift
//  Tutti
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be used to style the ``TutorialPageTabView``
 component with custom colors.
 */
@available(iOS 14.0, *)
public struct TutorialPageTabViewStyle {

    public init(
        pageIndicatorTintColor: Color,
        currentPageIndicatorTintColor: Color
    ) {
        self.pageIndicatorTintColor = pageIndicatorTintColor
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
    }

    public var pageIndicatorTintColor: Color
    public var currentPageIndicatorTintColor: Color
}

@available(iOS 14.0, *)
public extension TutorialPageTabViewStyle {

    /**
     This standard style applies a primary tint color to the
     indicators, with less opacity to non-current indicators.
     */
    static var standard = TutorialPageTabViewStyle(
        pageIndicatorTintColor: .primary.opacity(0.3),
        currentPageIndicatorTintColor: .primary)
}
