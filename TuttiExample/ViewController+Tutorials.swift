//
//  ViewController+Tutorials.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2018-02-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import Tutti

extension ViewController {
    
    func getLocalizedTutorial(forUser userId: String?) -> Tutorial {
        return StandardTutorial(
            fromLocalizationWithPageIndicationKey: "title",
            identifier: "localized",
            userId: userId)
    }
    
    func getTutorial(forUser userId: String?) -> Tutorial {
        return StandardTutorial(
            identifier: "standard",
            pageCount: 3,
            userId: userId)
    }
    
    func getDeferredTutorial(forUser userId: String?) -> DeferredTutorial {
        return DeferredTutorial(
            identifier: "deferred",
            pageCount: 3,
            requiredPresentationAttempts: 5,
            userId: userId)
    }
    
    func show(_ tutorial: Tutorial, from view: UIView) {
        if tutorial.hasBeenDisplayed { return alertAlreadyDisplayedTutorial() }
        //let presenter = TutorialViewController(nibName: nil, bundle: nil)
        let presenter = TutorialViewController(nibName: "YourCustomTutorialViewController", bundle: Bundle.main)
        presenter.cellType = YourCustomTutorialViewControllerCell.self
        presenter.present(tutorial, in: self, from: view)
        tutorialPresenter = presenter
    }
    
    func show(_ tutorial: DeferredTutorial, from view: UIView) {
        show(tutorial as Tutorial, from: view)
        alertRemainingPresentationAttemptsIfNeeded(for: tutorial)
    }
}

private extension ViewController {
    
    func alertAlreadyDisplayedTutorial() {
        alertAlreadyDisplayed(title: "This tutorial has already been displayed")
    }
    
    func alertRemainingPresentationAttemptsIfNeeded(for tutorial: DeferredTutorial) {
        let remainingAttempts = tutorial.remainingPresentationAttempts
        guard remainingAttempts > 0 else { return }
        alert(title: "Keep trying!", message: "This tutorial requires \(remainingAttempts) more taps before it is presented.")
    }
}
