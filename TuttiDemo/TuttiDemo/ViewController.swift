//
//  ViewController.swift
//  TuttiDemo
//
//  Created by Daniel Saidi on 2020-09-07.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit
import Tutti

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHintAppearance()
    }
    
    
    // MARK: - Properties
    
    private let standardHintOnboarding = Onboarding(id: "standard.hint")
    private let delayedHintOnboarding = DelayedOnboarding(id: "delayed.hint", requiredPresentationAttempts: 3)
    
    private let standardTutorialOnboarding = Onboarding(id: "standard.tutorial")
    private let delayedTutorialOnboarding = DelayedOnboarding(id: "delayed.tutorial", requiredPresentationAttempts: 3)
    private let localizedTutorialOnboarding = Onboarding(id: "localized.tutorial")
    
    private lazy var allOnboardings = [
        standardHintOnboarding,
        delayedHintOnboarding,
        standardTutorialOnboarding,
        delayedTutorialOnboarding,
        localizedTutorialOnboarding
    ]
    
    /// This is used to retain the view controller
    private var tutorialViewController: TutorialViewController<TutorialPage>!
    
    
    // MARK: - Outlets
    
    @IBOutlet var presentStandardHintCell: UITableViewCell!
    @IBOutlet var presentDelayedHintCell: UITableViewCell!
    
    @IBOutlet var presentStandardTutorialCell: UITableViewCell!
    @IBOutlet var presentLocalizedTutorialCell: UITableViewCell!
    @IBOutlet var presentDelayedTutorialCell: UITableViewCell!
    
    @IBOutlet weak var resetCell: UITableViewCell!
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        switch cell {
        case presentStandardHintCell: presentStandardHint(from: cell)
        case presentDelayedHintCell: presentDelayedHint(from: cell)
        case presentStandardTutorialCell: presentStandardTutorial(from: cell)
        case presentLocalizedTutorialCell: presentLocalizedTutorial(from: cell)
        case presentDelayedTutorialCell: presentDelayedTutorial(from: cell)
        case resetCell: reset()
        default: return
        }
    }
}


// MARK: - Setup Functions

extension ViewController {
    
    func setupHintAppearance() {
        var preferences = CalloutView.globalPreferences
        let green = UIColor(red: 11/255, green: 102/255, blue: 35/255, alpha: 1)
        preferences.drawing.backgroundColor = green
        CalloutView.globalPreferences = preferences
    }
}


// MARK: - Hint Functions

extension ViewController {
    
    func presentStandardHint(from cell: UIView) {
        let onboarding = standardHintOnboarding
        let hint = Hint(
            title: "Standard hint",
            text: "Standard hints are presented when you ask them to, and are only presented once.")
        CalloutHintPresenter().present(hint, with: onboarding, in: self, from: cell)
    }
    
    func presentDelayedHint(from cell: UIView) {
        let onboarding = delayedHintOnboarding
        let hint = Hint(
            title: "Delayed hint",
            text: "Delayed hints are presented after a certain number of attempts, and are only presented once.")
        CalloutHintPresenter().present(hint, with: onboarding, in: self, from: cell)
    }
}

extension ViewController {
    
    func presentStandardTutorial(from cell: UIView) {
        let onboarding = standardTutorialOnboarding
        let page1 = TutorialPage(title: "Page 1", text: "This tutorial was created in code.", imageName: "tutorial.0.image")
        let page2 = TutorialPage(title: "Page 2", text: "It is easy to create tutorials this way.", imageName: "tutorial.1.image")
        let page3 = TutorialPage(title: "Page 3", text: "But it's more convenient to create a localized tutorial.", imageName: "tutorial.2.image")
        let tutorial = Tutorial(pages: [page1, page2, page3])
        tutorialViewController = TutorialViewController(nibName: "TutorialViewController", bundle: nil)
        tutorialViewController.tutorial = tutorial
        tutorialViewController.present(tutorial, with: onboarding, in: self, from: cell)
    }
    
    func presentLocalizedTutorial(from cell: UIView) {}
    
    func presentDelayedTutorial(from cell: UIView) {}
}


// MARK: - Reset Functions

extension ViewController {
    
    func reset() {
        allOnboardings.forEach { $0.reset() }
    }
}
