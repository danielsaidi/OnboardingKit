//
//  Image+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Image {
    
    static let popover = Image.symbol("bubble")

    static var conditional = symbol("lightswitch.off")
    static var correctBehavior = symbol("hand.thumbsup")
    static var delayed = symbol("hand.raised")
    static var hint = symbol("heart.text")
    static var incorrectBehavior = symbol("hand.thumbsdown")
    static var pageView = symbol("book.pages")
    static var reset = symbol("multiply")
    static var sheet = symbol("rectangle.bottomhalf.inset.filled")
    static var slideshow = symbol("arrow.right.page.on.clipboard")
    static var tutorial = symbol("square.stack")
}

extension Image {
    
    static func symbol(_ name: String) -> Image {
        .init(systemName: name)
    }
    
    func label(_ text: String) -> some View {
        Label(
            title: { Text(text) },
            icon: { self }
        )
    }
}
