//
//  OnboardingUsp.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-21.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This model represents a unique selling point in an oboarding context.
public struct OnboardingUsp<Icon: View> {

    /// Create a USP value.
    ///
    /// - Parameters:
    ///   - title: An optional localized USP title.
    ///   - text: A localized USP text.
    ///   - icon: A USP icon view.
    public init(
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        icon: Icon
    ) {
        self.title = title
        self.text = text
        self.icon = icon
    }

    /// Create a USP value.
    ///
    /// - Parameters:
    ///   - title: An optional localized USP title.
    ///   - text: A localized USP text.
    ///   - image: A USP icon image.
    public init(
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey,
        image: Image
    ) where Icon == AnyView {
        self.init(
            title: title,
            text: text,
            icon: AnyView(image
                .resizable()
                .aspectRatio(contentMode: .fit)
            )
        )
    }

    /// An optional localized USP title.
    public let title: LocalizedStringKey?

    /// A localized USP text.
    public let text: LocalizedStringKey

    /// A USP icon image.
    public let icon: Icon
}
