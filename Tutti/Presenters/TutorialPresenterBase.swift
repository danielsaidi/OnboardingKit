//
//  TutorialPresenterBase.swift
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

open class TutorialPresenterBase: TutorialPresenter {
    
    public init() { }
    

    public func dismiss(tutorial: Tutorial) { }
    
    public func present(tutorial: Tutorial, in vc: UIViewController, from view: UIView) -> Bool {
        if tutorial.hasBeenDisplayed { return false }
        var tutorial = tutorial
        tutorial.hasBeenDisplayed = true
        return true
    }
}
