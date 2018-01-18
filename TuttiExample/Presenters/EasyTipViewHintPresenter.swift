//
//  EasyTipViewHintPresenter.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2017-12-10.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit
import Tutti
import EasyTipView

class EasyTipViewHintPresenter: HintPresenter {

    func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool {
        if hint.hasBeenDisplayed { return false }
        hint.hasBeenDisplayed = true
        EasyTipView.show(forView: view, text: hint.text)
        return true
    }
    
    func dismiss(hint: Hint) { }
}
