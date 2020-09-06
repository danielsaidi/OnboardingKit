//
//  Hint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A `hint` is a short onboarding message, that is intended to
 be displayed briefly to tell users about important parts of
 your app.
 */
open class Hint {
    
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
