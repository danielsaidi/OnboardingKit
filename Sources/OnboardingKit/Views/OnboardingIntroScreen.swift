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
/// This screen can be used to welcome users, show a summary of what the app
/// does, and list high-level USPs.
///
/// This view can be styled with``SwiftUICore/View/onboardingIntroScreenStyle(_:)`.
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
        self.bundle = bundle ?? .module
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
                    .easeInOut(duration: style.uspListPresentationDuration)
                    .delay(Double(index) * style.uspListPresentationDelay)
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
        VStack(alignment: .leading, spacing: style.uspListSpacing) {
            ForEach(Array(usps.enumerated()), id: \.offset) { item in
                uspListItem(for: item.element, at: item.offset)
            }
        }
        .padding(.horizontal, style.uspListPadding)
    }

    func uspListItem(for usp: Usp, at index: Int) -> some View {
        let isVisible = index < uspVisibility.count && uspVisibility[index]
        return OnboardingUspListItem(
            usp: usp,
            bundle: bundle
        )
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 20)
    }
}

extension View {

    func discrete() -> some View {
        self.opacity(0.7)
    }
}

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
                        icon: .init(systemName: "lightbulb")
                    ),
                    .init(
                        title: "Flows",
                        text: "Sophisticated **page views** and **slideshows**.",
                        icon: .init(systemName: "appwindow.swipe.rectangle")
                    ),
                    .init(
                        title: "Views",
                        text: "Reduce implementation time with screen templates, buttons, etc.",
                        icon: .init(systemName: "square")
                    ),
                    .init(
                        title: "Flows",
                        text: "Sophisticated **page views** and **slideshows**.",
                        icon: .init(systemName: "appwindow.swipe.rectangle")
                    ),
                    .init(
                        title: "Views",
                        text: "Reduce implementation time with screen templates, buttons, etc.",
                        icon: .init(systemName: "square")
                    )
                ]
            )
        }
    }
    .onboardingIntroScreenStyle(.init(
        uspListPresentationDelay: 0.1
    ))
}
