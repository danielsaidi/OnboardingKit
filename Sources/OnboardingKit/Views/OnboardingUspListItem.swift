//
//  OnboardingUspListItem.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-21.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

// MARK: - View

/// This view can be used to render an ``OnboardingUsp``.
///
/// This view can be customized with the following modifiers:
///
/// *``SwiftUICore/View/onboardingUspListItemStyle(_:)`.
public struct OnboardingUspListItem<UspIcon: View>: View {

    public init(
        usp: Usp
    ) {
        self.usp = usp
    }

    public typealias Usp = OnboardingUsp<UspIcon>

    private let usp: Usp

    @Environment(\.onboardingUspListItemStyle) var style

    public var body: some View {
        HStack(alignment: .top, spacing: 20) {
            iconView
                .foregroundStyle(style.iconColor ?? .accentColor)
                .frame(maxHeight: style.iconSize)
                .frame(maxWidth: style.iconSize)

            VStack(alignment: .leading) {
                if let title = usp.title {
                    Text(title)
                        .font(style.titleFont)
                        .foregroundStyle(style.titleColor)
                }
                Text(usp.text)
                    .font(style.textFont)
                    .foregroundStyle(style.textColor)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .multilineTextAlignment(.leading)
        }
    }
}

private extension OnboardingUspListItem {

    @ViewBuilder
    var iconView: some View {
        if let image = usp.image {
            image.resizable().aspectRatio(contentMode: .fit)
        } else {
            usp.icon
        }
    }
}

// MARK: - Style

/// This style can be used with ``OnboardingUspListItem``.
///
/// The style can define a custom icon color. If no color is
/// defined, icons will be tinted with the accent color.
///
/// This style can be applied with``SwiftUICore/View/onboardingUspListItemStyle(_:)`.
public struct OnboardingUspListItemStyle {

    public init(
        iconColor: Color? = nil,
        iconSize: Double = 30,
        titleColor: Color = .primary,
        titleFont: Font = .headline,
        textColor: Color = .secondaryOnboarding,
        textFont: Font = .callout
    ) {
        self.iconColor = iconColor
        self.iconSize = iconSize
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.textColor = textColor
        self.textFont = textFont
    }

    public var iconColor: Color?
    public var iconSize: Double
    public var titleColor: Color
    public var titleFont: Font
    public var textColor: Color
    public var textFont: Font
}

public extension OnboardingUspListItemStyle {

    /// The standard intro screen style.
    static var standard: Self { .init() }
}

public extension EnvironmentValues {

    @Entry var onboardingUspListItemStyle = OnboardingUspListItemStyle()
}

public extension View {

    func onboardingUspListItemStyle(
        _ style: OnboardingUspListItemStyle
    ) -> some View {
        self.environment(\.onboardingUspListItemStyle, style)
    }
}


// MARK: - Preview

#Preview {

    OnboardingUspListItem(
        usp: .init(
            title: "Foo",
            text: "Lorem Ipsum is simply dummy text of the printing and typesetting.",
            image: .init(systemName: "checkmark.circle")
        )
    )
    .background(Color.red)
    .accentColor(.orange)
    .onboardingUspListItemStyle(.init(
        iconColor: .purple,
        iconSize: 100
    ))
}
