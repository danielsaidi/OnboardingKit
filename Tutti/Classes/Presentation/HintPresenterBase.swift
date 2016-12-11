//
//  HintPresenterBase.swift
//  Tutti
//
//  Created by Daniel Saidi on 2016-12-11.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//

import UIKit

open class HintPresenterBase: NSObject, HintPresenter {
    
    open func present(hint: Hint, from view: UIView) -> Bool {
        let result = !hint.hasBeenDisplayed
        hint.hasBeenDisplayed = true
        // Implement presentation in a subclass
        return result
    }
}
