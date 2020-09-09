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
        reset()
        setupHintAppearance()
    }
    
    
    // MARK: - Properties
    
    private let correctBehaviorHintOnboarding = CorrectBehaviorOnboarding(id: "correct.behavior.hint", requiredIncorrectAttempts: 3)
    private let delayedHintOnboarding = DelayedOnboarding(id: "delayed.hint", requiredPresentationAttempts: 3)
    private let standardHintOnboarding = Onboarding(id: "standard.hint")
    private let standardHintWithoutTitleOnboarding = Onboarding(id: "standard.hint.notitle")
    
    private let correctBehaviorTutorialOnboarding = CorrectBehaviorOnboarding(id: "correct.behavior.tutorial", requiredIncorrectAttempts: 3)
    private let delayedTutorialOnboarding = DelayedOnboarding(id: "delayed.tutorial", requiredPresentationAttempts: 3)
    private let localizedTutorialOnboarding = Onboarding(id: "localized.tutorial")
    private let standardTutorialOnboarding = Onboarding(id: "standard.tutorial")
    
    private lazy var allOnboardings = [
        delayedHintOnboarding,
        standardHintOnboarding,
        standardHintWithoutTitleOnboarding,
        delayedTutorialOnboarding,
        localizedTutorialOnboarding,
        standardTutorialOnboarding
    ]
    
    /// This is used to retain the view controller
    private lazy var tutorialViewController = TutorialViewController(nibName: "TutorialViewController", bundle: nil)
    
    
    // MARK: - Outlets
    
    @IBOutlet var behaveCorrectlyHintCell: UITableViewCell!
    @IBOutlet var behaveIncorrectlyHintCell: UITableViewCell!
    @IBOutlet var presentStandardHintCell: UITableViewCell!
    @IBOutlet var presentStandardHintWithoutTitleCell: UITableViewCell!
    @IBOutlet var presentDelayedHintCell: UITableViewCell!
    
    @IBOutlet var behaveCorrectlyTutorialCell: UITableViewCell!
    @IBOutlet var behaveIncorrectlyTutorialCell: UITableViewCell!
    @IBOutlet var presentStandardTutorialCell: UITableViewCell!
    @IBOutlet var presentLocalizedTutorialCell: UITableViewCell!
    @IBOutlet var presentDelayedTutorialCell: UITableViewCell!
    
    @IBOutlet weak var resetCell: UITableViewCell!
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        switch cell {
        case behaveCorrectlyHintCell: behaveCorrectlyForHint()
        case behaveIncorrectlyHintCell: presentCorrectBehaviorHint(from: cell)
        case presentDelayedHintCell: presentDelayedHint(from: cell)
        case presentStandardHintCell: presentStandardHint(from: cell)
        case presentStandardHintWithoutTitleCell: presentStandardHintWithoutTitle(from: cell)
        
        case behaveCorrectlyTutorialCell: behaveCorrectlyForTutorial()
        case behaveIncorrectlyTutorialCell: presentCorrectBehaviorTutorial(from: cell)
        case presentDelayedTutorialCell: presentDelayedTutorial(from: cell)
        case presentLocalizedTutorialCell: presentLocalizedTutorial(from: cell)
        case presentStandardTutorialCell: presentStandardTutorial(from: cell)
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


// MARK: - Hint Functionality

extension ViewController {
    
    func behaveCorrectlyForHint() {
        correctBehaviorHintOnboarding.registerCorrectBehavior()
    }
    
    func presentCorrectBehaviorHint(from cell: UIView) {
        let onboarding = correctBehaviorHintOnboarding
        onboarding.registerIncorrectBehavior()
        let hint = Hint(
            title: "Incorrect behavior",
            text: "You can present any hint whenever a user keeps on behaving incorrectly, to educate your users. These hints will reset themselves.")
        present(hint, with: onboarding, from: cell)
    }
    
    func presentDelayedHint(from cell: UIView) {
        let hint = Hint(
            title: "Delayed hint",
            text: "You can present any hint as a delayed onboarding experience, which means that it is presented after a certain number of attempts.")
        present(hint, with: delayedHintOnboarding, from: cell)
    }
    
    func presentStandardHint(from cell: UIView) {
        let hint = Hint(
            title: "Standard hint",
            text: "Standard hints are presented when you ask them to, and are only presented once.")
        present(hint, with: standardHintOnboarding, from: cell)
    }
    
    func presentStandardHintWithoutTitle(from cell: UIView) {
        let hint = Hint(
            text: "Standard hints are presented when you ask them to, and are only presented once.")
        present(hint, with: standardHintWithoutTitleOnboarding, from: cell)
    }
    
    func present(_ hint: Hint, with onboarding: Onboarding, from cell: UIView) {
        CalloutHintPresenter().present(hint, with: onboarding, in: self, from: cell)
    }
}


// MARK: - Tutorial Functionality

extension ViewController {
    
    func behaveCorrectlyForTutorial() {
        correctBehaviorTutorialOnboarding.registerCorrectBehavior()
    }
    
    func presentCorrectBehaviorTutorial(from cell: UIView) {
        let onboarding = correctBehaviorTutorialOnboarding
        onboarding.registerIncorrectBehavior()
        let tutorial = LocalizedTutorial(id: "correct-behavior")
        present(tutorial, with: onboarding, from: cell)
    }
    
    func presentDelayedTutorial(from cell: UIView) {
        let page1 = TutorialPage(title: "Delayed tutorial", text: "You can present any tutorial as a delayed onboarding experience experience, which means that it is presented after a certain number of attempts.", imageName: "tutorial.0.image")
        let page2 = TutorialPage(title: "When to use it?", text: "Delayed onboarding experiences are great when you want to present a hint or tutorial after a while.", imageName: "tutorial.1.image")
        let tutorial = Tutorial(pages: [page1, page2])
        present(tutorial, with: delayedTutorialOnboarding, from: cell)
    }
    
    func presentLocalizedTutorial(from cell: UIView) {
        let tutorial = LocalizedTutorial(id: "localized")
        tutorialViewController = TutorialViewController(nibName: "TutorialViewController", bundle: nil)
        tutorialViewController.tutorial = tutorial
        present(tutorial, with: localizedTutorialOnboarding, from: cell)
    }
    
    func presentStandardTutorial(from cell: UIView) {
        let page1 = TutorialPage(title: "Standard tutorial", text: "This tutorial was created in code, by manually creating pages in the demo code.", imageName: "tutorial.0.image")
        let page2 = TutorialPage(title: "Easy to create", text: "It's really easy to create tutorials in this way, but it can also be tedious.", imageName: "tutorial.1.image")
        let page3 = TutorialPage(title: "Localized tutorials", text: "It's must more convenient and efficient to use localized tutorials. See the demo for examples.", imageName: "tutorial.2.image")
        let tutorial = Tutorial(pages: [page1, page2, page3])
        present(tutorial, with: standardTutorialOnboarding, from: cell)
    }
    
    func present(_ tutorial: Tutorial<TutorialPage>, with onboarding: Onboarding, from cell: UIView) {
        tutorialViewController = TutorialViewController(nibName: "TutorialViewController", bundle: nil)
        tutorialViewController.present(tutorial, with: onboarding, in: self, from: cell)
    }
}


// MARK: - Reset Functions

extension ViewController {
    
    func reset() {
        allOnboardings.forEach { $0.reset() }
    }
}
