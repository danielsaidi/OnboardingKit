//
//  ViewController+Hints.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2018-02-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import Tutti

extension ViewController {
    
    func getHint(forUser userId: String?) -> Hint {
        return StandardHint(
            identifier: "hint",
            title: "Standard hint",
            text: "This is a standard hint. It will only be displayed once per user.",
            userId: userId)
    }
    
    func getDeferredHint(forUser userId: String?) -> DeferredHint {
        let requiredPresentationAttempts = 5
        return StandardDeferredHint(
            identifier: "deferred_hint",
            title: "Deferred hint",
            text: "This is a deferred hint. It will be displayed after \(requiredPresentationAttempts) attempts and only once per user.",
            requiredPresentationAttempts: requiredPresentationAttempts,
            userId: userId)
    }
    
    func show(_ hint: Hint, from view: UIView) {
        if hint.hasBeenDisplayed { return alertAlreadyDisplayedHint() }
        hint.present(with: hintPresenter, in: self, from: view)
    }
    
    func show(_ hint: DeferredHint, from view: UIView) {
        if hint.hasBeenDisplayed { return alertAlreadyDisplayedHint() }
        hint.present(with: hintPresenter, in: self, from: view)
        alertRemainingPresentationAttemptsIfNeeded(for: hint)
    }
}

private extension ViewController {
    
    func alertAlreadyDisplayedHint() {
        alertAlreadyDisplayed(title: "This hint has already been displayed.")
    }
    
    func alertRemainingPresentationAttemptsIfNeeded(for hint: DeferredHint) {
        let remainingAttempts = hint.remainingPresentationAttempts
        guard remainingAttempts > 0 else { return }
        alertAlreadyDisplayed(title: "This hint requires \(remainingAttempts) more taps before it is presented.")
    }
}
