//
//  OnboardingUspList.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-22.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

// MARK: - View

/// This view can be used to list a collection of onboarding
/// USP items.
///
/// This view can be customized with the following modifiers:
/// 
/// * ``SwiftUICore/View/onboardingUspListStyle(_:)`.
public struct OnboardingUspList<UspIcon: View>: View {

    public init(
        usps: [Usp]
    ) {
        self.usps = usps
    }

    public typealias Usp = OnboardingUsp<UspIcon>

    private let usps: [Usp]

    @Environment(\.onboardingUspListStyle) var style

    @State private var uspVisibility: [Bool] = []

    public var body: some View {
        VStack(alignment: .leading, spacing: style.itemSpacing) {
            ForEach(Array(usps.enumerated()), id: \.offset) { item in
                listItem(for: item.element, at: item.offset)
            }
        }
        .onAppear(perform: presentItems)
        .padding(.horizontal, style.padding)
    }
}

private extension OnboardingUspList {

    func listItem(
        for usp: Usp,
        at index: Int
    ) -> some View {
        let isVisible = index < uspVisibility.count && uspVisibility[index]
        return OnboardingUspListItem(usp: usp)
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 20)
    }

    func presentItems() {
        uspVisibility = Array(repeating: false, count: usps.count)
        for index in usps.indices {
            withAnimation(
                .easeInOut(duration: style.itemPresentationDuration)
                .delay(Double(index) * style.itemPresentationDelay)
            ) {
                uspVisibility[index] = true
            }
        }
    }
}


// MARK: - Style

/// This style can be used with ``OnboardingUspList``.
///
/// This style can be applied with``SwiftUICore/View/onboardingUspListStyle(_:)`.
public struct OnboardingUspListStyle {

    public init(
        padding: Double = 0,
        itemSpacing: Double = 20,
        itemPresentationDuration: Double = 0.5,
        itemPresentationDelay: Double = 0.2
    ) {
        self.padding = padding
        self.itemSpacing = itemSpacing
        self.itemPresentationDuration = itemPresentationDuration
        self.itemPresentationDelay = itemPresentationDelay
    }

    public let padding: Double
    public let itemSpacing: Double
    public let itemPresentationDuration: Double
    public let itemPresentationDelay: Double
}

public extension OnboardingUspListStyle {

    /// The standard intro screen style.
    static var standard: Self { .init() }
}

public extension EnvironmentValues {

    @Entry var onboardingUspListStyle = OnboardingUspListStyle()
}

public extension View {

    func onboardingUspListStyle(
        _ style: OnboardingUspListStyle
    ) -> some View {
        self.environment(\.onboardingUspListStyle, style)
    }
}


// MARK: - Preview

#Preview {

    OnboardingUspList<Image>(
        usps: [
            .image(
                title: "Foo",
                text: "Lorem Ipsum is simply dummy text of the printing and typesetting.",
                image: .init(systemName: "checkmark.circle")
            ),
            .image(
                title: "Bar",
                text: "Lorem Ipsum is simply dummy text of the printing and typesetting.",
                image: .init(systemName: "checkmark.circle")
            ),
            .image(
                title: "Baz",
                text: "Lorem Ipsum is simply dummy text of the printing and typesetting.",
                image: .init(systemName: "checkmark.circle")
            )
        ]
    )
    .background(Color.red)
    .onboardingUspListStyle(.init(
        // itemSpacing: 40
    ))
}
