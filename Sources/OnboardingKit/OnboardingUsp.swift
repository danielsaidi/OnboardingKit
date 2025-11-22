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
        self.image = nil
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
    ) where Icon == Image {
        self.title = title
        self.text = text
        self.icon = image
        self.image = image
    }

    /// An optional localized USP title.
    public let title: LocalizedStringKey?

    /// A localized USP text.
    public let text: LocalizedStringKey

    /// A USP icon view.
    public let icon: Icon

    /// An optional USP icon image.
    public let image: Image?
}
