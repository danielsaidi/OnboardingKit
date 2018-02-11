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
    
    var options: [TableViewOption] {
        return [.hint, .tutorial, .localizedTutorial, .reset]
    }
    
    var userId: String?
    
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView? {
        didSet {
            guard let view = tableView else { return }
            view.dataSource = self
            view.delegate = self
        }
    }
}


// MARK: - Actions

extension ViewController {
    
    @IBAction func setupUser(_ sender: Any) {
        setupUser()
    }
}


// MARK: - Public Functions

extension ViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertAlreadyDisplayed(title: String) {
        alert(title: title, message: "Press 'reset' to reset its display state. You can then display it again.")
    }
    
    func resetDisplayState() {
        let onboardings: [Onboarding] = [
            getHint(forUser: userId),
            getTutorial(forUser: userId),
            getLocalizedTutorial(forUser: userId)
        ]
        onboardings.forEach { $0.hasBeenDisplayed = false }
        alert(title: "Done!", message: "All hints and tutorials are now set to not displayed")
    }
}
