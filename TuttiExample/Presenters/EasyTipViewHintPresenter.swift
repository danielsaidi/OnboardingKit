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

class EasyTipViewHintPresenter: HintPresenterBase {

    override func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool {
        guard super.present(hint: hint, in: vc, from: view) else { return false }
        EasyTipView.show(forView: view, text: hint.text)
        return true
    }
    
    override func dismiss(hint: Hint) { }
}
