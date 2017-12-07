//
//  TutorialViewControllerPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This presenter can be used to display a fullscreen tutorial,
 using the `TutorialViewController` class. It will present a
 tutorial by presenting the view controller as a modal using
 the standard `present(animated:completion:)` function. This
 means that you can customize the presentation in any way by
 modifying the tutorial view controller or the presenting vc.
 
 */


import UIKit

open class TutorialViewControllerPresenter: TutorialPresenterBase {
    
    
    // MARK: - Initialization
    
    public init(vc: TutorialViewController) {
        self.tutorialViewController = vc
        super.init()
    }
    
    
    // MARK: - Properties
    
    fileprivate weak var presentingViewController: UIViewController?
    fileprivate weak var tutorialViewController: TutorialViewController?
    
    
    // MARK: - Public Functions
    
    open override func dismiss(tutorial: Tutorial) {
        guard
            let tutorialViewController = self.tutorialViewController
            else { return }
        tutorialViewController.dismiss(animated: true, completion: nil)
    }
    
    open override func present(tutorial: Tutorial, in vc: UIViewController, from view: UIView) -> Bool {
        guard
            super.present(tutorial: tutorial, in: vc, from: view),
            let tutorialViewController = self.tutorialViewController
            else { return false }
        tutorialViewController.tutorial = tutorial
        vc.present(tutorialViewController, animated: true, completion: nil)
        return true
    }
}
