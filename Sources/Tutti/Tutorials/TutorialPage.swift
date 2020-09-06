//
//  TutorialPage.swift
//  Tutti
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This is a base class for tutorial pages. You can use it
 as is or inherit and extend it.
 
 This base class represents a tutorial page with a title,
 a text and an image. If you want more, you can create a
 custom page type and use that instead.
 */
open class TutorialPage {
    
    public init(
        title: String,
        text: String,
        accessibilityText: String? = nil) {
        self.title = title
        self.text = text
        self.accessibilityText = accessibilityText
    }
    
    public let title: String
    public let text: String
    public let accessibilityText: String?
}
