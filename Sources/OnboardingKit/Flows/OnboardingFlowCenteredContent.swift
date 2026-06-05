//
//  OnboardingFlowCenteredContent.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2026-06-05.
//

import SwiftUI

/// This view can be used to wrap the content view of a view
/// that is presented in an onboarding flow.
///
/// The view will apply an edge padding and a max view width,
/// and center the content inside the available content area.
public struct OnboardingFlowCenteredContent<Content: View>: View {

    /// Create a centered onboarding screen content view.
    ///
    /// - Parameters:
    ///   - maxWidth: The max content width, by default `500`.
    ///   - content: The content to wrap.
    public init(
        maxWidth: Double = 500,
        content: @escaping () -> Content
    ) {
        self.maxWidth = maxWidth
        self.content = content
    }

    private var maxWidth: Double
    private var content: () -> Content

    public var body: some View {
        content()
            .padding()
            .multilineTextAlignment(.center)
            .frame(maxWidth: maxWidth, alignment: .center)
            .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {

    OnboardingFlowCenteredContent(
        maxWidth: 250
    ) {
        Color.red
    }
}
