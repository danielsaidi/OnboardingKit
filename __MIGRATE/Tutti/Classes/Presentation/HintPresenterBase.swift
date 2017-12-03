//
//  HintPresenterBase.swift
//  Tutti
//
//  Created by Daniel Saidi on 2016-12-11.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//

/*
 
 When subclassing this base class, check the base result
 to see if a hint should be displayed, then add a custom
 presentation to the base class. You should also make it
 possible to dismiss the current hint.
 
 */

import UIKit

open class HintPresenterBase: NSObject, HintPresenter {
    
    open func dismissCurrentHint() { }
    
    open func present(hint: Hint, from view: UIView) -> Bool {
        guard !hint.hasBeenDisplayed else { return false }
        hint.hasBeenDisplayed = true
        return true
    }
}
