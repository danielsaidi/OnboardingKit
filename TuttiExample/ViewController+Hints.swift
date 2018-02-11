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
    
    func alertAlreadyDisplayedHint() {
        alertAlreadyDisplayed(title: "This hint has already been displayed")
    }
    
    func getHint(forUser userId: String?) -> Hint {
        return StandardHint(identifier: "hint", title: "Hint, hint!", text: "This is a quick hint. It will only be displayed once.", userId: userId)
    }
    
    func showHint(forUser userId: String?, from view: UIView) {
        let hint = getHint(forUser: userId)
        if !hintPresenter.present(hint: hint, in: self, from: view) {
            alertAlreadyDisplayedHint()
        }
    }
}
