//
//  OnboardingUspList.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-22.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used to list a collection of ``OnboardingUsp`` items.
///
/// This view can be styled with``SwiftUICore/View/onboardingUspListStyle(_:)`.
public struct OnboardingUspList<UspIcon: View>: View {

    public init(
        usps: [Usp],
        bundle: Bundle? = nil
    ) {
        self.usps = usps
        self.bundle = bundle ?? .module
    }

    public typealias Usp = OnboardingUsp<UspIcon>

    private let usps: [Usp]
    private let bundle: Bundle

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

    func listItem(for usp: Usp, at index: Int) -> some View {
        let isVisible = index < uspVisibility.count && uspVisibility[index]
        return OnboardingUspListItem(
            usp: usp,
            bundle: bundle
        )
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
