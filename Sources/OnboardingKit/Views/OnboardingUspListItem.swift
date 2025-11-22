//
//  OnboardingUspListItem.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-21.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

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

#Preview {

    OnboardingUspListItem(
        usp: .init(
            title: "Foo",
            text: "Lorem Ipsum is simply dummy text of the printing and typesetting.",
            image: .init(systemName: "checkmark.circle")
        )
    )
    .background(Color.red)
}
