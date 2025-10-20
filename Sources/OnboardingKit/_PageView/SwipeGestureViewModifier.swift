//
//  SwipeGestureViewModifier.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2020-01-03.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
import SwiftUI

/// This view  modifier can be used to apply swipe gestures that will trigger actions
/// when the view is swiped in any direction.
struct SwipeGestureViewModifier: ViewModifier {

    init(
        maximumTime: TimeInterval = 1,
        minimumDistance: CGFloat = 10,
        maximumDistance: CGFloat = 100_000,
        up: Action? = nil,
        left: Action? = nil,
        right: Action? = nil,
        down: Action? = nil
    ) {
        self.maximumTime = maximumTime
        self.minimumDistance = minimumDistance
        self.maximumDistance = maximumDistance
        self.up = up
        self.left = left
        self.right = right
        self.down = down
    }

    var maximumTime: TimeInterval
    var minimumDistance: CGFloat
    var maximumDistance: CGFloat
    var up: Action?
    var left: Action?
    var right: Action?
    var down: Action?

    typealias Action = () -> Void

    func body(content: Content) -> some View {
        content.gesture(
            DragGesture(minimumDistance: minimumDistance)
                .onChanged { _ in }
                .onEnded { gesture in
                    let translation = gesture.translation
                    let absHeight = abs(translation.height)
                    let absWidth = abs(translation.width)
                    let isVertical = absHeight > absWidth
                    let points = isVertical ? absHeight : absWidth
                    if points > maximumDistance { return }
                    if isVertical {
                        if translation.height < 0 {
                            up?()
                        } else {
                            down?()
                        }
                    } else {
                        if translation.width < 0 {
                            left?()
                        } else {
                            right?()
                        }
                    }
                }
        )
    }
}

extension View {
    
    func onSwipeGesture(
        maximumTime: TimeInterval = 1,
        minimumDistance: CGFloat = 10,
        maximumDistance: CGFloat = 100_000,
        up: SwipeGestureViewModifier.Action? = nil,
        left: SwipeGestureViewModifier.Action? = nil,
        right: SwipeGestureViewModifier.Action? = nil,
        down: SwipeGestureViewModifier.Action? = nil
    ) -> some View {
        self.modifier(
            SwipeGestureViewModifier(
                maximumTime: maximumTime,
                minimumDistance: minimumDistance,
                maximumDistance: maximumDistance,
                up: up,
                left: left,
                right: right,
                down: down
            )
        )
    }
}
#endif
