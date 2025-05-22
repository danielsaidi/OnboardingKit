//
//  OnboardingPrimaryButton.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import Foundation
import SwiftUI

/// This view defines a primary onboarding page.
public struct OnboardingPrimaryButton<Label: View>: View {

    /// Create a primary onboarding button with a text title.
    ///
    /// - Parameters:
    ///   - title: The page title.
    ///   - bundle: The bundle of the localized string.
    ///   - type: The button type, by default `.primary`.
    ///   - action: The button action.
    public init(
        _ title: LocalizedStringKey,
        bundle: Bundle? = nil,
        type: OnboardingPrimaryButtonType = .primary,
        action: @escaping () -> Void
    ) where Label == Text {
        self.label = Text(title, bundle: bundle)
        self.type = type
        self.action = action
    }

    /// Create a primary onboarding button.
    ///
    /// - Parameters:
    ///   - type: The button type, by default `.primary`.
    ///   - action: The button action.
    ///   - label: The button label.
    public init(
        _ type: OnboardingPrimaryButtonType = .primary,
        action: @escaping () -> Void,
        label: @escaping () -> Label
    ) {
        self.label = label()
        self.type = type
        self.action = action
    }

    private let label: Label
    private let type: OnboardingPrimaryButtonType
    private let action: () -> Void

    public var body: some View {
        Button(action: action) {
            label.onboardingButtonLabel()
        }
        .onboardingButton(type)
        .onboardingButtonSize()
    }
}

/// This enum defines various primary button types.
public enum OnboardingPrimaryButtonType {
    case primary, secondary
}

private extension View {

    @ViewBuilder
    func onboardingButton(
        _ type: OnboardingPrimaryButtonType
    ) -> some View {
        switch type {
        case .primary: self.buttonStyle(.borderedProminent)
        case .secondary: self.buttonStyle(.bordered)
        }
    }

    func onboardingButtonSize() -> some View {
        #if os(tvOS)
        self
        #else
        self.controlSize(.large)
        #endif
    }

    func onboardingButtonLabel() -> some View {
        self.lineLimit(1)
            .frame(maxWidth: .infinity)
    }
}


#Preview {

    VStack {
        OnboardingPrimaryButton(
            "Preview.Title",
            action: {}
        )
        HStack {
            OnboardingPrimaryButton(
                "Preview.Title",
                type: .secondary,
                action: {}
            )
            OnboardingPrimaryButton(.primary, action: {}) {
                Text("Test")
            }
        }
    }
    .padding()
}
