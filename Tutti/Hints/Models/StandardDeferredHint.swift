//
//  StandardDeferredHint.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-06-19.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This is a simple standard implementation of `DeferredHint`
 protocol. You can use it as is or inherit it to create your
 own specific hint types.
 
 */

import UIKit

open class StandardDeferredHint: StandardHint, DeferredHint {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        title: String,
        text: String,
        requiredPresentationAttempts: Int,
        userId: String? = nil,
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.requiredPresentationAttempts = requiredPresentationAttempts
        super.init(
            identifier: identifier,
            title: title,
            text: text,
            userId: userId,
            persistence: persistence)
    }
    
    
    // MARK: - Properties
    
    public let requiredPresentationAttempts: Int
    
    open override var shouldBePresented: Bool {
        return super.shouldBePresented && remainingPresentationAttempts == 0
    }
    
    
    // MARK: - Public Functions
    
    open override func present(with presenter: HintPresenter, in vc: UIViewController, from view: UIView) {
        registerPresentationAttempt()
        guard shouldBePresented else { return }
        super.present(with: presenter, in: vc, from: view)
    }
}
