//
//  Hint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This is a very simple implementation of the `Hint` protocol.
 You can use it as it is or as a base class for custom hints.
 
 */

import Foundation

open class StandardHint: Hint {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        text: String,
        userId: String? = nil) {
        self.identifier = identifier
        self.text = text
        self.userId = userId
    }
    
    
    // MARK: - Properties
    
    public weak var presenter: HintPresenter?
    
    public let identifier: String
    public let text: String
    public let userId: String?
}
