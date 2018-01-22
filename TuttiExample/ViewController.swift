//
//  ViewController.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit
import Tutti

class ViewController: UIViewController {

    
    // MARK: - Dependencies
    
    let hintPresenter = EasyTipViewHintPresenter()
    var tutorialPresenter: TutorialPresenter?
    
    
    // MARK: - Properties
    
    fileprivate let sections: [(title: String, options: [ViewControllerListOption])] = [
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


// MARK: - Private Functions

fileprivate extension ViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertAlreadyDisplayed(title: String) {
        alert(title: title, message: "Press 'reset' to reset its display state. You can then display it again.")
    }
    
    func alertAlreadyDisplayedHint() {
        alertAlreadyDisplayed(title: "This hint has already been displayed")
    }
    
    func alertAlreadyDisplayedTutorial() {
        alertAlreadyDisplayed(title: "This tutorial has already been displayed")
    }
    
    func getHint(forUser userId: String?) -> Hint {
        return StandardHint(identifier: "hint", text: "This is a quick hint. It will only be displayed once.", userId: userId)
    }
    
    func getLocalizedTutorial(forUser userId: String?) -> Tutorial {
        return LocalizedTutorial(identifier: "localized", userId: userId)
    }
    
    func getTutorial(forUser userId: String?) -> Tutorial {
        return StandardTutorial(identifier: "standard", pageCount: 3, userId: userId)
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
    
    func showHint(forUser userId: String?, from view: UIView) {
        let hint = getHint(forUser: userId)
        if !hintPresenter.present(hint: hint, in: self, from: view) {
            alertAlreadyDisplayedHint()
        }
    }
    
    func showTutorial(forUser userId: String?, from view: UIView) {
        let tutorial = getTutorial(forUser: userId)
        let presenter = TutorialViewController(nibName: nil, bundle: nil)
        if !presenter.present(tutorial: tutorial, in: self, from: view) {
            alertAlreadyDisplayedTutorial()
        }
        tutorialPresenter = presenter
    }
    
    func showLocalizedTutorial(forUser userId: String?, from view: UIView) {
        let tutorial = getLocalizedTutorial(forUser: userId)
        let presenter = TutorialViewController(nibName: nil, bundle: nil)
        if !presenter.present(tutorial: tutorial, in: self, from: view) {
            alertAlreadyDisplayedTutorial()
        }
        tutorialPresenter = presenter
    }
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func listOption(at indexPath: IndexPath) -> ViewControllerListOption {
        return sections[indexPath.section].options[indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "Cell"
        let option = listOption(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: id)
            ?? UITableViewCell(style: .default, reuseIdentifier: id)
        cell.textLabel?.text = option.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let option = listOption(at: indexPath)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        switch option {
        case .hint(let userId): showHint(forUser: userId, from: cell)
        case .reset: resetDisplayState()
        case .tutorial(let userId): showTutorial(forUser: userId, from: cell)
        case .localizedTutorial(let userId): showLocalizedTutorial(forUser: userId, from: cell)
        }
    }
}
