//
//  AlertingHintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-01-22.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//


#if os(iOS) || os(tvOS)
import UIKit

/**
 This presenter presents hints by using standard alerts.
 
 This presenter is mostly meant to be used while you work on
 implementing a real presenter. You should never use it in a
 real world app, since the experience is horrible. Do better
 than this. Life is not a game! Come on!
 */
open class AlertingHintPresenter: HintPresenter {
    
    public init(okText: String = "OK") {
        self.okText = okText
    }
    
    private let okText: String
    
    open func present(
        _ hint: Hint,
        with onboarding: Onboarding,
        in vc: UIViewController) {
        tryPresent(onboarding) {
            alert(hint: hint, from: vc)
        }
    }
}

private extension AlertingHintPresenter {
    
    func alert(hint: Hint, from vc: UIViewController) {
        let alert = UIAlertController(title: hint.title, message: hint.text, preferredStyle: .alert)
        let ok = UIAlertAction(title: okText, style: .default, handler: nil)
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
    }
}
#endif
