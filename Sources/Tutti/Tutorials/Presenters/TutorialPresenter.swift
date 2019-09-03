//
//  TutorialPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 Tutti tutorial presenters can be used to present a tutorial
 to users.
 
 Tutti comes with a built-in presenter, which you can use in
 your app with some setup. Have a look at the example app to
 see how I use `TutorialViewController` to setup a scrolling,
 full screen tutorial.
 */
public protocol TutorialPresenter: OnboardingPresenter {
    
    func dismiss(_ tutorial: Tutorial)
    func present(_ tutorial: Tutorial, in vc: UIViewController, from view: UIView)
}
