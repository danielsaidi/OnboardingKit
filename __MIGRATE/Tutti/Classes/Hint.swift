//
//  Hint.swift
//  Tutti
//
//  Created by Daniel Saidi on on 2016-12-11.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//

/*
 
 A hint is a quick message, intended to be displayed only
 once. It is perfect for quick onboarding, like showing a
 user what a certain button does.
 
*/

import Foundation

public protocol Hint: class {

    var identifier: String { get }
    
    var hasBeenDisplayed: Bool { get set }
    var text: String { get }
}
