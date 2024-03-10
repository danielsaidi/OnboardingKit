//
//  UrlTutorialPage.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This tutorial page adds a url to the basic page information.

 This is a basic example of how to create custom page types.
 */
open class UrlTutorialPage: TutorialPage {

    /// Create a tutorial page.
    ///
    /// - Parameters:
    ///   - id: The unique ID of the page, by default a unique `UUID`.
    ///   - title: The page title.
    ///   - text: The page text.
    ///   - url: The url that a user can navigate to.
    ///   - imageName: The name of the image asset, by default `nil`.
    public init(
        id: UUID = UUID(),
        title: String,
        text: String,
        url: URL,
        imageName: String? = nil
    ) {
        self.url = url
        super.init(
            id: id,
            title: title,
            text: text,
            imageName: imageName
        )
    }

    /// The url that a user can navigate to.
    public let url: URL
}
