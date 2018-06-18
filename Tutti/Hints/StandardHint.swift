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
        userId: String? = nil,
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.identifier = identifier
        self.title = title
        self.text = text
        self.userId = userId
        self.persistence = persistence
    }
    
    
    // MARK: - Properties
    
    public weak var presenter: HintPresenter?
    
    public let identifier: String
    public let text: String
    public let title: String
    public let userId: String?
    
    public let persistence: OnboardingPersistence
    
    
    // MARK: - Public Functions
    
    public func present(with presenter: HintPresenter, in vc: UIViewController, from view: UIView) {
        if hasBeenDisplayed { return }
        hasBeenDisplayed = true
        presenter.present(hint: self, in: vc, from: view)
    }
}
