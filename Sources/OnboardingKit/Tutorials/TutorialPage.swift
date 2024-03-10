//
//  TutorialPage.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This base class represents a tutorial page, with a title, a
 text and an image name.

 The class can be used as is or subclassed and extended with
 more information.
 */
open class TutorialPage: Identifiable {

    /**
     Create a tutorial page.

     - Parameters:
       - id: The unique ID of the page, by default a unique `UUID`.
       - title: The page title.
       - text: The page text.
       - imageName: The name of the image asset, by default `nil`.
     */
    public init(
        id: UUID = UUID(),
        title: String,
        text: String,
        imageName: String? = nil
    ) {
        self.id = id
        self.title = title
        self.text = text
        self.imageName = imageName
    }

    /// The unique ID of the page.
    public let id: UUID

    /// The page title.
    public let title: String

    /// The page text.
    public let text: String

    /// The name of the image asset.
    public let imageName: String?
}
