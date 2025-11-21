//
//  OnboardingUspListitem.swift
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
                text(usp.text).discrete()
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
