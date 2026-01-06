//
//  OnboardingSlideshowProgressView.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can present progress in a story slideshow.
public struct OnboardingSlideshowProgressView: View {
    
    /// Create a slideshow progress view.
    ///
    /// - Parameters:
    ///   - index: The slide index.
    ///   - slideshowIndex: The current slideshow index.
    ///   - slideshowProgress: The current slideshow progress.
    public init(
        index: Int,
        slideshowIndex: Int,
        slideshowProgress: Double
    ) {
        self.index = index
        self.slideshowIndex = slideshowIndex
        self.slideshowProgress = slideshowProgress
    }
    
    private let index: Int
    private let slideshowIndex: Int
    private let slideshowProgress: Double

    @Environment(\.onboardingSlideshowStyle)
    private var style

    public var body: some View {
        GeometryReader { geometry in
            Capsule()
                .fill(style.progressBarBackgroundColor)
            Capsule()
                .fill(style.progressBarForegroundColor)
                .frame(width: barWidth(for: geometry), alignment: .leading)
        }
        .frame(height: style.progressBarHeight)
    }
}

private extension OnboardingSlideshowProgressView {

    var progress: Double {
        if index < slideshowIndex { return 1 }
        if index > slideshowIndex { return 0 }
        return slideshowProgress
    }

    func barWidth(for geo: GeometryProxy) -> Double {
        geo.size.width * progress
    }
}

#Preview {

    let slideshowIndex = 4
    let slideshowProgress = 0.5

    return HStack {
        ForEach(0...5, id: \.self) {
            OnboardingSlideshowProgressView(
                index: $0,
                slideshowIndex: slideshowIndex,
                slideshowProgress: slideshowProgress
            )
        }
    }
    .padding()
    .onboardingSlideshowStyle(.preview)
}

private extension OnboardingSlideshowStyle {

    static var preview: Self {
        .init(
            progressBarBackgroundColor: .blue,
            progressBarForegroundColor: .yellow,
            progressBarHeight: 10
        )
    }
}
