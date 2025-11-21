//
//  OnboardingUspListItem.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-21.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used to render an ``OnboardingUsp``.
public struct OnboardingUspListItem<UspIcon: View>: View {

    public init(
        usp: Usp,
        bundle: Bundle? = nil
    ) {
        self.usp = usp
        self.bundle = bundle ?? .module
    }

    public typealias Usp = OnboardingUsp<UspIcon>

    private let usp: Usp
    private let bundle: Bundle

    @Environment(\.onboardingUspListItemStyle) var style

    public var body: some View {
        HStack(alignment: .top, spacing: 20) {
            usp.icon
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

    func text(_ text: LocalizedStringKey) -> some View {
        Text(text, bundle: bundle)
    }
}

#Preview {

    OnboardingUspListItem(
        usp: .init(
            title: "Foo",
            text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            image: .init(systemName: "checkmark.circle")
        )
    )
    .background(Color.red)
}
