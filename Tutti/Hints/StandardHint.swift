//
//  StandardHint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This is a very simple, standard implementation of the `Hint`
 protocol.
 
 */

import Foundation

open class StandardHint: Hint {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        title: String,
        text: String,
        userId: String? = nil) {
        self.identifier = identifier
        self.title = title
        self.text = text
        self.userId = userId
    }
    
    
    // MARK: - Properties
    
    public weak var presenter: HintPresenter?
    
    public let identifier: String
    public let text: String
    public let title: String
    public let userId: String?
}
