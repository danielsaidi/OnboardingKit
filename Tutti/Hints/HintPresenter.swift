//
//  HintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 Tutti hint presenters can be used to present hints to users.
 
 Tutti does not yet come with any built-in presenters, but I
 will try to add some later. Until then, you can have a look
 at the example app, where I use a 3rd party lib to create a
 simple hint presenter.
 
 */

import UIKit

public protocol HintPresenter: class {
    
    func dismiss(hint: Hint)
    func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool
}
