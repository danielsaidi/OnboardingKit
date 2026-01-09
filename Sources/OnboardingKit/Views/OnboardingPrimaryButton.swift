//
//  OnboardingPrimaryButton.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This view defines a primary onboarding button.
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
///
/// > Note: The glass variants will only render as glass for
/// platforms where the glass effect is available.
public enum OnboardingPrimaryButtonType {

    case primary, secondary
    case primaryGlass, secondaryGlass
}

private extension View {

    @ViewBuilder
    func onboardingButton(
        _ type: OnboardingPrimaryButtonType
    ) -> some View {
        switch type {
        case .primary:
            self.buttonStyle(.borderedProminent)
        case .primaryGlass:
            #if os(visionOS)
            self.buttonStyle(.borderedProminent)
            #else
            if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *) {
                self.buttonStyle(.glassProminent)
            } else {
                self.buttonStyle(.borderedProminent)
            }
            #endif
        case .secondary: self.buttonStyle(.bordered)
        case .secondaryGlass:
            #if os(visionOS)
            self.buttonStyle(.bordered)
            #else
            if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *) {
                self.buttonStyle(.glass)
            } else {
                self.buttonStyle(.bordered)
            }
            #endif
        }
    }

    func onboardingButtonSize() -> some View {
        #if os(tvOS) || os(watchOS)
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
                type: .secondaryGlass,
                action: {}
            )
            OnboardingPrimaryButton(
                .primaryGlass,
                action: {},
                label: { Text("Test") }
            )
        }
        HStack {
            OnboardingPrimaryButton(
                "Preview.Title",
                type: .secondary,
                action: {}
            )
            OnboardingPrimaryButton(
                .primary,
                action: {},
                label: { Text("Test") }
            )
        }
    }
    .padding()
    .background(.red)
    .tint(.orange)
}
