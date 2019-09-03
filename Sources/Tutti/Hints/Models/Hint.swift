//
//  Hint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol represents a short onboarding message that is
 intended to be displayed only once, to tell users about the
 most important parts of your app or game.
 
 For more info on how to use it, check out the documentation
 for `Onboarding`.
 */
public protocol Hint: Onboarding {
    
    var title: String { get }
    var text: String { get }
    var accessibilityText: String? { get }
}
