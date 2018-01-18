//
//  HintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 Hint presenters can be used to present hints to an app user.
 By separating hints from their presentations, a hint can be
 presented in many different ways.
 
 Tutti does not (yet) come with any presenter, since the way
 hints are presented can differ greatly between apps. I will
 hopefully add one later, but until I do, check out the demo
 app, where I use an external library to create a presenter.
 
 */

import UIKit

public protocol HintPresenter: class {
    
    func dismiss(hint: Hint)
    func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool
}
