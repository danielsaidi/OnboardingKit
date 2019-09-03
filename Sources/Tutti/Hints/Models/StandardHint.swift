//
//  StandardHint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This is a basic hint that can be used as is or inherited to
 create custom hints. You can present it using any presenter.
 */
open class StandardHint: Hint {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        title: String,
        text: String,
        accessibilityText: String? = nil,
        userId: String? = nil,
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.accessibilityText = accessibilityText
        self.identifier = identifier
        self.title = title
        self.text = text
        self.userId = userId
        self.persistence = persistence
    }
    
    
    // MARK: - Dependencies
    
    public let persistence: OnboardingPersistence
    
    
    // MARK: - Properties
    
    public let accessibilityText: String?
    public let identifier: String
    public let text: String
    public let title: String
    public let userId: String?
    
    public var shouldBePresented: Bool {
        return !hasBeenDisplayed
    }
    
    
    // MARK: - Public Functions
    
    open func prepareForPresentation() {}
}
