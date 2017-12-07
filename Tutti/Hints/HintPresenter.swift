//
//  HintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 Hint presenters can be used to present hints to a user. The
 separation of hints from their presentations means that the
 same hint can be presented in many different ways.
 
 Tutti does not come with any built-in presenters, since the
 way hints are presented can differ greatly between apps. In
 the demo app, I use a nice library for hint callouts. Check
 out how I extend that lib with `HintPresenter` capabilities.
 
 When creating your own hint presenters, you can inherit the
 `HintPresenterBase` base class, which handles display state
 when presenting and dismissing hints.
 
 */

import UIKit

public protocol HintPresenter {
    
    func dismiss(hint: Hint)
    func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool
}
