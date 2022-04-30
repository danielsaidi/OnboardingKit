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
open class TutorialPage: Identifiable {
    
    public init(
        id: UUID = UUID(),
        title: String,
        text: String,
        imageName: String? = nil) {
        self.id = id
        self.title = title
        self.text = text
        self.imageName = imageName
    }
    
    public let id: UUID
    public let title: String
    public let text: String
    public let imageName: String?
}
