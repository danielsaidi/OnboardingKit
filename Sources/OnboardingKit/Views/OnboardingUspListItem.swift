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
/// This view can be styled with``SwiftUICore/View/onboardingUspListItemStyle(_:)`.
public struct OnboardingUspListItem<UspIcon: View>: View {

    public init(
        usp: Usp,
        bundle: Bundle? = nil
    ) {
        self.usp = usp
        self.bundle = bundle ?? .main
    }

    public typealias Usp = OnboardingUsp<UspIcon>

    private let usp: Usp
    private let bundle: Bundle

    @Environment(\.onboardingUspListItemStyle) var style

    public var body: some View {
        HStack(alignment: .top, spacing: 20) {
            iconView
                .frame(maxHeight: style.iconSize)
                .frame(maxWidth: style.iconSize)

            VStack(alignment: .leading) {
                if let title = usp.title {
                    text(title)
                        .font(.headline)
                }
                text(usp.text)
                    .discrete()
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

    func text(_ text: LocalizedStringKey) -> some View {
        Text(text, bundle: bundle)
    }
}

// MARK: - Style

/// This style can be used with ``OnboardingUspListItem``.
///
/// This style can be applied with``SwiftUICore/View/onboardingUspListItemStyle(_:)`.
public struct OnboardingUspListItemStyle {

    public init(
        iconSize: Double = 35
    ) {
        self.iconSize = iconSize
    }

    public let iconSize: Double
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
    .onboardingUspListItemStyle(.init(
        iconSize: 100)
    )
}
