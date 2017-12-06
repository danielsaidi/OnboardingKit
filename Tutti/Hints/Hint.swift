//
//  Hint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 A hint is a simple message that is intended to be displayed
 only once. It is perfect for quick onboarding, like showing
 users how a certain part of a UI works.
 
 `StandardHint` provides you with a simple implementation of
 this protocol.
 
 */

import Foundation

public protocol Hint: Displayable {
    
    var text: String { get }
}
