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
    
    func alertAlreadyDisplayedTutorial() {
        alertAlreadyDisplayed(title: "This tutorial has already been displayed")
    }
    
    func getLocalizedTutorial(forUser userId: String?) -> Tutorial {
        return StandardTutorial(fromLocalizationWithPageIndicationKey: "title", identifier: "localized", userId: userId)
    }
    
    func getTutorial(forUser userId: String?) -> Tutorial {
        return StandardTutorial(identifier: "standard", pageCount: 3, userId: userId)
    }
    
    func showLocalizedTutorial(forUser userId: String?, from view: UIView) {
        let tutorial = getLocalizedTutorial(forUser: userId)
        if tutorial.hasBeenDisplayed { return alertAlreadyDisplayedTutorial() }
        let presenter = TutorialViewController(nibName: nil, bundle: nil)
        tutorial.present(with: presenter, in: self, from: view)
        tutorialPresenter = presenter
    }
    
    func showTutorial(forUser userId: String?, from view: UIView) {
        let tutorial = getTutorial(forUser: userId)
        if tutorial.hasBeenDisplayed { return alertAlreadyDisplayedTutorial() }
        let presenter = TutorialViewController(nibName: nil, bundle: nil)
        tutorial.present(with: presenter, in: self, from: view)
        tutorialPresenter = presenter
    }
}
