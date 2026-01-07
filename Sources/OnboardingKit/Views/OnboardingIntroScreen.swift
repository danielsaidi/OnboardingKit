//
//  OnboardingIntroScreen.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-17.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

// MARK: - View

/// This screen can be used to onboard new users.
///
/// This screen can be used to welcome users, show a summary
/// of what the app does, and list high-level USPs.
///
/// This view can be styled with ``SwiftUICore/View/onboardingIntroScreenStyle(_:)``
/// and uses views that can be styled using their own styles,
/// like ``SwiftUICore/View/onboardingUspListStyle(_:)`` and
/// ``SwiftUICore/View/onboardingUspListItemStyle(_:)``.
public struct OnboardingIntroScreen<UspIcon: View>: View {

    public init(
        icon: Image,
        welcomeTitle: LocalizedStringKey?,
        title: LocalizedStringKey,
        text: LocalizedStringKey,
        bundle: Bundle? = nil,
        usps: [Usp],
        uspIcon: @escaping (Usp) -> UspIcon
    ) {
        self.icon = icon
        self.welcomeTitle = welcomeTitle
        self.title = title
        self.text = text
        self.usps = usps
        self.bundle = bundle ?? .main
        self.uspIcon = uspIcon
    }

    public init(
        icon: Image,
        welcomeTitle: LocalizedStringKey?,
        title: LocalizedStringKey,
        text: LocalizedStringKey,
        bundle: Bundle? = nil,
        usps: [Usp],
    ) where UspIcon == Image {
        self.init(
            icon: icon,
            welcomeTitle: welcomeTitle,
            title: title,
            text: text,
            bundle: bundle,
            usps: usps,
            uspIcon: { $0.icon }
        )
    }

    public typealias Usp = OnboardingUsp<UspIcon>

    private let icon: Image
    private let welcomeTitle: LocalizedStringKey?
    private let title: LocalizedStringKey
    private let text: LocalizedStringKey
    private let bundle: Bundle
    private let usps: [Usp]
    private let uspIcon: (Usp) -> UspIcon

    @Environment(\.onboardingIntroScreenStyle) var style

    public var body: some View {
        VStack(spacing: style.sectionSpacing) {
            titleStack
            text(text)
                .discrete()
                .font(.title3)
            OnboardingUspList(usps: usps, bundle: bundle)
        }
        .padding(.horizontal)
        .multilineTextAlignment(.center)
    }
}

private extension OnboardingIntroScreen {

    func text(
        _ text: LocalizedStringKey
    ) -> some View {
        Text(text, bundle: bundle)
    }

    var titleStack: some View {
        VStack(spacing: style.titleSpacing) {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: style.iconSize)
            VStack(spacing: 3) {
                if let welcomeTitle {
                    text(welcomeTitle)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                text(title)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
            }
        }
    }
}

extension View {

    func discrete() -> some View {
        self.opacity(0.7)
    }
}


// MARK: - Style

/// This style can be used with ``OnboardingIntroScreen``.
///
/// This style can be applied with``SwiftUICore/View/onboardingIntroScreenStyle(_:)`.
public struct OnboardingIntroScreenStyle {

    public init(
        iconSize: Double = 100,
        titleSpacing: Double = 25,
        sectionSpacing: Double = 45
    ) {
        self.iconSize = iconSize
        self.titleSpacing = titleSpacing
        self.sectionSpacing = sectionSpacing
    }

    public let iconSize: Double
    public let titleSpacing: Double
    public let sectionSpacing: Double
}

public extension OnboardingIntroScreenStyle {

    /// The standard intro screen style.
    static var standard: Self { .init() }
}

public extension EnvironmentValues {

    @Entry var onboardingIntroScreenStyle = OnboardingIntroScreenStyle()
}

public extension View {

    func onboardingIntroScreenStyle(
        _ style: OnboardingIntroScreenStyle
    ) -> some View {
        self.environment(\.onboardingIntroScreenStyle, style)
    }
}



// MARK: - Preview

#Preview {

    ScrollView(.vertical) {
        OnboardingFlowCenteredContent {
            OnboardingIntroScreen(
                icon: Image("Icon", bundle: .module),
                welcomeTitle: "Welcome to",
                title: "OnboardingKit",
                text: "This SDK lets you create a great onboarding experience for your users.",
                usps: [
                    .init(
                        title: "Onboarding",
                        text: "Design great onboardings with various **onboarding types**.",
                        image: .init(systemName: "lightbulb")
                    ),
                    .init(
                        title: "Flows",
                        text: "Sophisticated **page views** and **slideshows**.",
                        image: .init(systemName: "appwindow.swipe.rectangle")
                    ),
                    .init(
                        title: "Views",
                        text: "Reduce implementation time with screen templates, buttons, etc.",
                        image: .init(systemName: "square")
                    ),
                    .init(
                        title: "Flows",
                        text: "Sophisticated **page views** and **slideshows**.",
                        image: .init(systemName: "appwindow.swipe.rectangle")
                    ),
                    .init(
                        title: "Views",
                        text: "Reduce implementation time with screen templates, buttons, etc.",
                        image: .init(systemName: "square")
                    )
                ]
            )
        }
    }
    .onboardingIntroScreenStyle(.init(
        iconSize: 30,
        sectionSpacing: 35
    ))
    .onboardingUspListStyle(.init(
        itemSpacing: 15
    ))
    .onboardingUspListItemStyle(.init(
        iconSize: 30
    ))
}
