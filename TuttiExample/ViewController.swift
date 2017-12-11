//
//  ViewController.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit
import EasyTipView
import Tutti

class ViewController: UIViewController {


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("HEJ")
    }
    
    
    // MARK: - Dependencies
    
    let hintPresenter = EasyTipViewHintPresenter()
    var tutorialPresenter: TutorialPresenter?
    
    
    // MARK: - Properties
    
    var displayables: [Displayable] {
        return [
            StandardHint(identifier: "hint", text: ""),
            StandardTutorial(identifier: "basic", pageCount: 0, userId: nil),
            StandardTutorial(identifier: "basic", pageCount: 0, userId: "1"),
            StandardTutorial(identifier: "basic", pageCount: 0, userId: "2"),
            LocalizedTutorial(identifier: "l10n")
        ]
    }
    
    let rows = [
        (id: "hint", title: "Show a quick hint"),
        (id: "tutorial", title: "Show basic tutorial"),
        (id: "tutorial_user1", title: "Show basic tutorial for user #1"),
        (id: "tutorial_user2", title: "Show basic tutorial for user #2"),
        (id: "tutorial_l10n", title: "Show localized tutorial"),
        (id: "reset", title: "Reset display state")
    ]
    
    
    // MARK: - Outlets

    @IBOutlet weak var hintCell: UITableViewCell!

    @IBOutlet weak var tableView: UITableView? {
        didSet {
            guard let view = tableView else { return }
            view.dataSource = self
            view.delegate = self
        }
    }
    
    
    // MARK: - Example Functions
    
    func resetDisplayState() {
        displayables.forEach {
            var displayable = $0
            displayable.hasBeenDisplayed = false
        }
        alert(title: "Done!", message: "All hints and tutorials are now marked as not displayed")
    }
    
    func showHint(from view: UIView) {
        let text = "This is a quick hint. It will only be displayed once."
        let hint = StandardHint(identifier: "hint", text: text)
        if hint.hasBeenDisplayed { return alertHasAlreadyBeenDisplayed("This hint") }
        _ = hintPresenter.present(hint: hint, in: self, from: view)
    }
    
    func showBasicTutorial(forUser userId: String?, from view: UIView) {
        let tutorial = StandardTutorial(identifier: "basic", pageCount: 1, userId: userId)
        if tutorial.hasBeenDisplayed { return alertHasAlreadyBeenDisplayed("This tutorial") }
        let vc = TutorialViewController(nibName: nil, bundle: nil)
        tutorialPresenter = TutorialViewControllerPresenter(vc: vc)
        _ = tutorialPresenter?.present(tutorial: tutorial, in: self, from: view)
    }
}


// MARK: - Private Functions

fileprivate extension ViewController {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertHasAlreadyBeenDisplayed(_ prefix: String) {
        let title = "\(prefix) has already been displayed"
        let message = "You can reset its' display state to display it again"
        alert(title: title, message: message)
    }
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "Cell"
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: id)
            ?? UITableViewCell(style: .default, reuseIdentifier: id)
        cell.textLabel?.text = row.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = rows[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        switch row.id {
        case "hint": showHint(from: cell)
        case "tutorial": showBasicTutorial(forUser: nil, from: cell)
        case "tutorial_user1": showBasicTutorial(forUser: "1", from: cell)
        case "tutorial_user2": showBasicTutorial(forUser: "2", from: cell)
        case "reset": resetDisplayState()
        default: print("No match")
        }
    }
}

