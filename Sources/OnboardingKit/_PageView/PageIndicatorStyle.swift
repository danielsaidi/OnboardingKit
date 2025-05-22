//
//  PageIndicatorStyle.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2022-03-30.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This style can be used to style a `PageIndicator`.
struct PageIndicatorStyle: Equatable {
    
    /// Create a custom page indicator style.
    ///
    /// - Parameters:
    ///   - dotColor: The indicator dot color, by default `.white` with 0.5 opacity.
    ///   - dotSize: The indicator dot size, by default `10`.
    ///   - currentDotColor: The indicator current dot color, by default `.white`.
    ///   - currentDotSize: The indicator current dot size, by default `10`.
    ///   - dotSpacing: The spacing to apply between dots, by default `nil`.
    ///   - isAnimated: Whether or not changing pages is animated, by default `true`.
    init(
        dotColor: Color = .white.opacity(0.5),
        dotSize: CGFloat = 7,
        dotSpacing: CGFloat? = nil,
        currentDotColor: Color = .white,
        currentDotSize: CGFloat = 7,
        isAnimated: Bool = true
    ) {
        self.dotColor = dotColor
        self.dotSize = dotSize
        self.dotSpacing = dotSpacing
        self.currentDotColor = currentDotColor
        self.currentDotSize = currentDotSize
        self.isAnimated = isAnimated
    }
    
    /// The indicator current dot color.
    var currentDotColor: Color
    
    /// The indicator current dot size.
    var currentDotSize: CGFloat
    
    /// The indicator dot color.
    var dotColor: Color
    
    /// The indicator dot size.
    var dotSize: CGFloat
    
    /// The spacing to apply between dots.
    var dotSpacing: CGFloat?
    
    /// Whether or not changing pages is animated.
    var isAnimated: Bool
}

extension PageIndicatorStyle {

    /// The standard page indicator style.
    static var standard: Self { .init() }
}
