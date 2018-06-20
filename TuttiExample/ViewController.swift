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
    
    let hintPresenter: HintPresenter = CalloutHintPresenter()
    var tutorialPresenter: TutorialPresenter?
    
    
    // MARK: - Properties
    
    var options: [TableViewOption] {
        return [.hint, .deferredHint, .tutorial, .localizedTutorial, .deferredTutorial, .reset]
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
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyAppearance()
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
        let deferredHint = getDeferredHint(forUser: userId)
        let deferredTutorial = getDeferredTutorial(forUser: userId)
        let onboardings: [Onboarding] = [
            getHint(forUser: userId),
            deferredHint,
            getTutorial(forUser: userId),
            getLocalizedTutorial(forUser: userId),
            deferredTutorial
        ]
        onboardings.forEach { $0.hasBeenDisplayed = false }
        deferredHint.registeredPresentationAttempts = 0
        deferredTutorial.registeredPresentationAttempts = 0
        alert(title: "Done!", message: "All hints and tutorials are now set to not displayed")
    }
}
