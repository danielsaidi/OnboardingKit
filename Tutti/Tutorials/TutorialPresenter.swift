//
//  TutorialPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 Tutorial presenters are used to present tutorials to a user.
 By separating tutorials from their presentations, tutorials
 can be presented in many different ways.
 
 Tutti comes with a view controller presenter, which you can
 use to quickly get started. However, you will probably want
 to create custom presenters in your various apps.
 
 */

import UIKit

public protocol TutorialPresenter: class {
    
    func dismiss(tutorial: Tutorial)
    func present(tutorial: Tutorial, in vc: UIViewController, from view: UIView) -> Bool
}
