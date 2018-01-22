//
//  AlertingHintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-01-22.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This hint presenter displays hints with standard iOS alerts.
 It's mostly meant to be used as a temporary presenter while
 you work on adding a real presenter to your app. It is also
 a fallback presenter that is used by the nice, but disabled
 `EasyTipViewHintPresenter` in the demo app until you follow
 the instructions and add `EasyTipView` to the app. Try that.
 
 Never ever use this presenter in a real world app. You must
 do better than this. Life is not a game! Come on!
 
 */

import UIKit

public class AlertingHintPresenter: HintPresenter {
    
    public init() {}
    
    public func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool {
        if hint.hasBeenDisplayed { return false }
        hint.hasBeenDisplayed = true
        alert(hint, in: vc)
        return true
    }
    
    public func dismiss(hint: Hint) { }
}

fileprivate extension AlertingHintPresenter {
    
    func alert(_ hint: Hint, in vc: UIViewController) {
        let alert = UIAlertController(title: hint.title, message: hint.text, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
    }
}
