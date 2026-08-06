//
//  OnboardingIntroScreen.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-17.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

// MARK: - View

/// This screen can be used to onboard new users and quickly
/// describe the essentials of the app.
///
/// This screen can show a summary of what the app does, and
/// a list of high-level USPs. You can use a custom `uspIcon`
/// builder to customize the original USP icons.
///
/// The view can be styled with the following view modifiers:
///
/// * ``SwiftUICore/View/onboardingIntroScreenStyle(_:)``
/// * ``SwiftUICore/View/onboardingUspListStyle(_:)``
/// * ``SwiftUICore/View/onboardingUspListItemStyle(_:)``.
public struct OnboardingIntroScreen<UspIcon: View>: View {

    public init(
        icon: Image,
        welcomeTitle: LocalizedStringResource? = nil,
        title: LocalizedStringResource,
        text: LocalizedStringResource,
        usps: [Usp],
        uspIcon: @escaping (Usp) -> UspIcon
    ) {
        self.icon = icon
        self.welcomeTitle = welcomeTitle
        self.title = title
        self.text = text
        self.usps = usps
        self.uspIcon = uspIcon
    }

    public init(
        icon: Image,
        welcomeTitle: LocalizedStringResource? = nil,
        title: LocalizedStringResource,
        text: LocalizedStringResource,
        usps: [OnboardingUsp<UspIcon>]
    ) {
        self.init(
            icon: icon,
            welcomeTitle: welcomeTitle,
            title: title,
            text: text,
            usps: usps,
            uspIcon: { $0.icon }
        )
    }

    public init(
        icon: Image,
        welcomeTitle: LocalizedStringResource? = nil,
        title: LocalizedStringResource,
        text: LocalizedStringResource,
        usps: [OnboardingUsp<Image>]
    ) where UspIcon == Image {
        self.init(
            icon: icon,
            welcomeTitle: welcomeTitle,
            title: title,
            text: text,
            usps: usps,
            uspIcon: { $0.icon }
        )
    }

    public typealias Usp = OnboardingUsp<UspIcon>

    private let icon: Image
    private let welcomeTitle: LocalizedStringResource?
    private let title: LocalizedStringResource
    private let text: LocalizedStringResource
    private let usps: [Usp]
    private let uspIcon: (Usp) -> UspIcon

    @Environment(\.onboardingIntroScreenStyle) var style

    public var body: some View {
        VStack(spacing: style.sectionSpacing) {
            titleStack
            Text(text)
                .font(.title3)
                .foregroundStyle(style.secondaryColor)
                .padding(.bottom, style.additionalUspSpacing)
            OnboardingUspList(usps: usps)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, style.uspPadding)
        }
        .padding(.horizontal)
        .multilineTextAlignment(.center)
    }
}

private extension OnboardingIntroScreen {

    var titleStack: some View {
        VStack(spacing: style.titleSpacing) {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: style.iconSize)
            VStack(spacing: 0) {
                if let welcomeTitle {
                    Text(welcomeTitle)
                        .font(.title3)
                        .foregroundStyle(style.secondaryColor)
                }
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundStyle(style.primaryColor)
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
/// This style can be applied with ``SwiftUICore/View/onboardingIntroScreenStyle(_:)`.
public struct OnboardingIntroScreenStyle {

    public init(
        iconSize: Double = 100,
        titleSpacing: Double = 25,
        sectionSpacing: Double = 35,
        additionalUspSpacing: Double = 10,
        uspPadding: Double = 0,
        primaryColor: Color = .primary,
        secondaryColor: Color = .secondaryOnboarding
    ) {
        self.iconSize = iconSize
        self.titleSpacing = titleSpacing
        self.sectionSpacing = sectionSpacing
        self.additionalUspSpacing = additionalUspSpacing
        self.uspPadding = uspPadding
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }

    public let iconSize: Double
    public let titleSpacing: Double
    public let sectionSpacing: Double
    public let additionalUspSpacing: Double
    public let uspPadding: Double
    public let primaryColor: Color
    public let secondaryColor: Color
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

    let usps: [OnboardingUsp<Image>] = [
        .init(
            title: "Onboarding",
            text: "Design",// great onboardings with various **onboarding types**.",
            image: .init(systemName: "lightbulb")
        ),
        .init(
            title: "Flows",
            text: "Sophisticated",// **page views** and **slideshows**.",
            image: .init(systemName: "appwindow.swipe.rectangle")
        ),
        .init(
            title: "Views",
            text: "Reduce",// implementation time with screen templates, buttons, etc.",
            image: .init(systemName: "square")
        ),
        .init(
            title: "Flows",
            text: "Sophisticated",// **page views** and **slideshows**.",
            image: .init(systemName: "appwindow.swipe.rectangle")
        ),
        .init(
            title: "Views",
            text: "Reduce",// implementation time with screen templates, buttons, etc.",
            image: .init(systemName: "square")
        )
    ]

    NavigationStack {
        ScrollView(.vertical) {
            OnboardingFlowCenteredContent {
                OnboardingIntroScreen(
                    icon: Image("Icon", bundle: .module),
                    welcomeTitle: "Welcome to",
                    title: "OnboardingKit",
                    text: "This SDK lets you create a great onboarding experience for your users.",
                    usps: usps
                )
            }
        }
        .navigationTitle("Welcome")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
//    .onboardingIntroScreenStyle(.init(
//        iconSize: 30,
//        sectionSpacing: 35
//    ))
//    .onboardingUspListStyle(.init(
//        itemSpacing: 15
//    ))
//    .onboardingUspListItemStyle(.init(
//        iconSize: 30
//    ))
}
