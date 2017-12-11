//
//  HintPresenterBase.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This base class takes care of display state when presenting
 and dismissing hints.
 
 */

import UIKit

open class HintPresenterBase: HintPresenter {

    
    // MARK: - Initialization
    
    public init() { }
    

    // MARK: - Public Functions
    
    open func dismiss(hint: Hint) { }
    
    open func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool {
        if hint.hasBeenDisplayed { return false }
        var hint = hint
        hint.presenter = self
        hint.hasBeenDisplayed = true
        return true
    }
}
