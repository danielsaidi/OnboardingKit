//
//  EasyTipViewHintPresenter.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2017-12-10.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 To enable this presenter, follow the steps below (read more
 on why this presenter is initially disabled further down):
 
  * Uncomment the `EasyTipView` import
  * Remove the `alert` line above `EasyTipView.show(...)`
  * Uncomment the `EasyTipView.show(...)` line
 
 I had to disable this presenter, since I have problems with
 `EasyTipView` when Carthage fetches and builds Tutti. Since
 the unit test suite requires localized strings from the app,
 the app must be built together with the Tutti library. This
 fails, however, since the internal `EasyTipView` dependency
 is not checked out, which cause the app to not compile. The
 `EasyTipView` dependency can be made public, but this still
 does not solve the problem, since it is not properly linked.
 For now, I solved this by disabling the parts that requires
 `EasyTipView`. If you checkout the example from GitHub, you
 can just enable the lines, since EasyTipView is checked out
 together with the source code.
 
 */

import UIKit
import Tutti
//import EasyTipView

class EasyTipViewHintPresenter: HintPresenter {

    func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool {
        if hint.hasBeenDisplayed { return false }
        hint.hasBeenDisplayed = true
        alertWarning(in: vc)
        //EasyTipView.show(forView: view, text: hint.text)
        return true
    }
    
    func dismiss(hint: Hint) { }
}

fileprivate extension EasyTipViewHintPresenter {
    
    func alertWarning(in vc: UIViewController) {
        let title = "You must enable EasyTipViewHintPresenter"
        let message = "Check the EasyTipViewHintPresenter.swift file for instructions on how to enable this presenter."
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
    }
}
