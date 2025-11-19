//
//  OnboardingIntroScreen.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-17.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This screen can be used as an intro screen when onboarding new users.
///
/// This is a one-page screen that welcomes the user, shows a summary text of
/// what the app does, and lists high-level USPs.
///
/// This view is not wrapped in a scroll view, to allow you to control its spacing,
/// padding, placement, etc.
///
/// This view can be styled with``SwiftUICore/View/onboardingIntroScreenStyle(_:)`.
public struct OnboardingIntroScreen: View {

    public init(
        icon: Image,
        welcomeTitle: LocalizedStringKey?,
        title: LocalizedStringKey,
        text: LocalizedStringKey,
        usps: [Usp],
        bundle: Bundle? = nil
    ) {
        self.icon = icon
        self.welcomeTitle = welcomeTitle
        self.title = title
        self.text = text
        self.usps = usps
        self.bundle = bundle
    }

    public struct Usp {

        public init(
            title: LocalizedStringKey? = nil,
            icon: Image,
            text: LocalizedStringKey
        ) {
            self.title = title
            self.icon = icon
            self.text = text
        }

        public let title: LocalizedStringKey?
        public let icon: Image
        public let text: LocalizedStringKey
    }

    private let icon: Image
    private let welcomeTitle: LocalizedStringKey?
    private let title: LocalizedStringKey
    private let text: LocalizedStringKey
    private let usps: [Usp]
    private let bundle: Bundle?

    @Environment(\.onboardingIntroScreenStyle) var style

    @State private var uspVisibility: [Bool] = []

    public var body: some View {
        VStack(spacing: 45) {
            titleStack
            text(text)
                .discrete()
                .font(.title3)
            uspList
        }
        .padding(.horizontal)
        .multilineTextAlignment(.center)
        .onAppear {
            uspVisibility = Array(repeating: false, count: usps.count)
            for index in usps.indices {
                withAnimation(
                    .easeInOut(duration: style.uspPresentationDuration)
                    .delay(Double(index) * style.uspPresentationDelay)
                ) {
                    uspVisibility[index] = true
                }
            }
        }
    }
}

private extension OnboardingIntroScreen {

    func text(
        _ text: LocalizedStringKey
    ) -> some View {
        Text(text, bundle: bundle)
    }

    var titleStack: some View {
        VStack(spacing: 25) {
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

    var uspList: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(Array(usps.enumerated()), id: \.offset) { item in
                uspListItem(for: item.element, at: item.offset)
            }
        }
        .padding(.horizontal, 0)
    }

    func uspListItem(for usp: Usp, at index: Int) -> some View {
        let isVisible = index < uspVisibility.count && uspVisibility[index]
        return HStack(alignment: .top, spacing: 20) {
            usp.icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: style.uspIconSize)
                .frame(maxWidth: style.uspIconSize)

            VStack(alignment: .leading) {
                if let title = usp.title {
                    text(title)
                        .font(.headline)
                }
                text(usp.text).discrete()
            }
            .multilineTextAlignment(.leading)
        }
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 20)
    }
}

/// This style can be used with ``OnboardingIntroScreen``.
///
/// This style can be applied with``SwiftUICore/View/onboardingIntroScreenStyle(_:)`.
public struct OnboardingIntroScreenStyle {

    public init(
        iconSize: Double = 100,
        uspIconSize: Double = 45,
        uspPadding: Double = 0,
        uspPresentationDuration: Double = 0.5,
        uspPresentationDelay: Double = 0.2
    ) {
        self.iconSize = iconSize
        self.uspIconSize = uspIconSize
        self.uspPadding = uspPadding
        self.uspPresentationDuration = uspPresentationDuration
        self.uspPresentationDelay = uspPresentationDelay
    }

    public let iconSize: Double
    public let uspIconSize: Double
    public let uspPadding: Double
    public let uspPresentationDuration: Double
    public let uspPresentationDelay: Double
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

private extension View {

    func discrete() -> some View {
        self.opacity(0.7)
    }
}

#Preview {

    ScrollView(.vertical) {
        OnboardingIntroScreen(
            icon: Image("Icon", bundle: .module),
            welcomeTitle: "Welcome to",
            title: "OnboardingKit",
            text: "This SDK lets you create a great onboarding experience for your users.",
            usps: [
                .init(
                    title: "Onboarding",
                    icon: .init(systemName: "lightbulb"),
                    text: "Design great onboardings with various **onboarding types**."
                ),
                .init(
                    title: "Flows",
                    icon: .init(systemName: "appwindow.swipe.rectangle"),
                    text: "Sophisticated **page views** and **slideshows**."
                ),
                .init(
                    title: "Views",
                    icon: .init(systemName: "square"),
                    text: "Reduce implementation time with screen templates, buttons, etc."
                )
            ]
        )
        .padding()
    }
    .onboardingIntroScreenStyle(.init(
        uspPresentationDelay: 0.1
    ))
}
