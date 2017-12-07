//
//  TutorialPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 Tutorial presenters can be used to present tutorials to the
 user. Separating tutorials from their presentations means a
 tutorial can be presented in many different ways.
 
 Tutti comes with a base presenter for full-screen tutorials,
 but does not add much more than so, since the way tutorials
 are presented can differ greatly between apps. Checkout the
 demo app to see how I present full screen tutorials there.
 
 When creating your own tutorial presenters, you can inherit
 `TutorialPresenterBase`, which handles display state when a
 tutorial is presented and dismissed.
 
 */

import UIKit

public protocol TutorialPresenter {
    
    func dismiss(tutorial: Tutorial)
    func present(tutorial: Tutorial, in vc: UIViewController, from view: UIView) -> Bool
}
