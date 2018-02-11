//
//  ViewController.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 To make the example easier to overview, the view controller
 has been split up into many smaller files.
 
 */

import UIKit
import Tutti

class ViewController: UIViewController {

    
    // MARK: - Dependencies
    
    let hintPresenter = EasyTipViewHintPresenter()
    var tutorialPresenter: TutorialPresenter?
    
    
    // MARK: - Properties
    
    let sections: [(title: String, options: [TableViewOption])] = [
        ("Hint", [.hint(userId: nil), .hint(userId: "user")]),
        ("Tutorial", [.tutorial(userId: nil), .tutorial(userId: "user")]),
        ("Localized tutorial", [.localizedTutorial(userId: nil), .localizedTutorial(userId: "user")]),
        ("Reset", [.reset])
    ]
    
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView? {
        didSet {
            guard let view = tableView else { return }
            view.dataSource = self
            view.delegate = self
        }
    }
}


// MARK: - Public Functions

extension ViewController {
    
    func alertAlreadyDisplayed(title: String) {
        alert(title: title, message: "Press 'reset' to reset its display state. You can then display it again.")
    }
    
    func resetDisplayState() {
        let onboardings: [Onboarding] = [
            getHint(forUser: nil),
            getHint(forUser: "user"),
            getTutorial(forUser: nil),
            getTutorial(forUser: "user"),
            getLocalizedTutorial(forUser: nil),
            getLocalizedTutorial(forUser: "user")
        ]
        onboardings.forEach { $0.hasBeenDisplayed = false }
        alert(title: "Done!", message: "All hints and tutorials are now set to not displayed")
    }
}


// MARK: - Private Functions

fileprivate extension ViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
