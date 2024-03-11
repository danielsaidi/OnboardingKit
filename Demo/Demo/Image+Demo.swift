//
//  Image+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Image {
    
    static let popover = Image.symbol("bubble")
    
    static var correctBehavior = Image(systemName: "hand.thumbsup.circle")
    static var delayed = Image(systemName: "hand.raised.circle")
    static var hint = Image(systemName: "heart.text.square")
    static var incorrectBehavior = Image(systemName: "hand.thumbsdown.circle")
    static var reset = Image(systemName: "multiply.circle")
    static var tutorial = Image(systemName: "square.stack")
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
